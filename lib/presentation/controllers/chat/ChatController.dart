import 'dart:convert';
import 'dart:io' as DartIO;

import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Chat/ChatFirestore.dart';
import 'package:doctorcare/data/models/Chat/ChatModel.dart';
import 'package:doctorcare/data/models/home/DoctorDetailResponse.dart';
import 'package:doctorcare/data/models/home/ListMedicalRecords.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/data/providers/network/apis/home_api.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/chat/CreateRecipe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:universal_html/html.dart' as UniversalHtml;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  var chatFireStore = ChatFirestore().obs;

  ChatFirestoreController chatFirestoreController = Get.find();

  HomePatientController? patientController;
  HomeDoctorController? doctorController;

  ColorIndex colorIndex = ColorIndex();

  var shownName = ''.obs;
  var shownImage = ''.obs;
  var isScreenLoading = true.obs;
  var logger = Logger();
  var chatList = <ChatItem>[].obs;
  final _picker = ImagePicker();
  var currentChatRoom = ''.obs;

  var isDoctor = false.obs;

  late final IO.Socket socket;
  TextEditingController chatTextController = TextEditingController();
  ScrollController chatScrollController = ScrollController();

  var listMedicalRecord = ListMedicalRecord().obs;

  var chatRoomName;
  var patientName;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    var thisIsDoctor = false;

    if (Get.isRegistered<HomePatientController>()) {
      patientController = Get.find<HomePatientController>();
      thisIsDoctor = false;
      isDoctor.value = false;
      update();
    }

    if (Get.isRegistered<HomeDoctorController>()) {
      doctorController = Get.find<HomeDoctorController>();
      thisIsDoctor = true;
      isDoctor.value = true;
      update();
    }

    if (thisIsDoctor) {
      getListMedicalRecord(
          doctorController!.selectedFirestoreChat.value.patientID!);
      shownImage.value = doctorController!.selectedFirestoreChat.value.image!;
      shownName.value =
          doctorController!.selectedFirestoreChat.value.patientName!;
    } else {
      shownImage.value = patientController!.detailDoctor.value!.data!.image!;
      shownName.value = patientController!.detailDoctor.value!.data!.name!;
    }
    isScreenLoading.value = false;
    update();
    onSocketInitalize();
    socketListener();
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
  }

  void onSendMessage() async {
    if (chatTextController!.text.isNotEmpty) {
      socket.emit('chat_message', {'message': chatTextController.text});
      chatTextController.clear();
    }
  }

  Future getListMedicalRecord(String patientCode) async {
    try {
      ListMedicalRecord response = await HomeApi().listHistory(patientCode);

      if (response.status == 'success') {
        listMedicalRecord.value = response;

        logger.i('SUCCESS FETCH PATIENT DATA ' + response.toString());

        shownName.value = listMedicalRecord.value.data!.user!.name!;
        update();
      } else {
        FToast().warningToast(response.message);
      }
    } on Exception catch (e) {
      FToast().errorToast(e.toString());
    } finally {
      update();
    }
  }

  void onSendRecipe(String diagnose, String rawRecipe) {
    var stringBuilder = 'Alternative diagnose : \n${diagnose} \n \nMedicine';

    var splitted = rawRecipe.split('no!!');

    for (int index = 0; index < splitted.length; index++) {
      if (splitted[index].isNotEmpty) {
        var rowToBeInserted = '\n- ';

        var splittedDesc = splitted[index].split('!desc!');

        rowToBeInserted =
            '$rowToBeInserted${splittedDesc[0]} = ${splittedDesc[1]}';

        stringBuilder = stringBuilder + rowToBeInserted;
      }
    }

    logger.i('Receipt ' + stringBuilder);

    ChatFirestore item = ChatFirestore(
      documentId: doctorController!.selectedFirestoreChat.value.getDocID(),
      medicine: rawRecipe,
      diagnose: diagnose,
      amount: doctorController!.selectedFirestoreChat.value.amount,
      date: doctorController!.selectedFirestoreChat.value.date,
      doctorID: doctorController!.selectedFirestoreChat.value.doctorID,
      doctorName: doctorController!.selectedFirestoreChat.value.doctorName,
      image: doctorController!.selectedFirestoreChat.value.image,
      patientID: doctorController!.selectedFirestoreChat.value.patientID,
      patientName: doctorController!.selectedFirestoreChat.value.patientName,
    );

    chatFirestoreController.onUpdateRecipe(item);

    socket.emit('chat_message', {'message': stringBuilder});
  }

  void onSocketInitalize() {
    EasyLoading.show();
    socket = IO.io('https://doctorcare.site', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
  }

  void socketListener() {
    logger.e('called');
    socket.onConnect((_) {
      isScreenLoading.value = false;
      FToast().successToast('Connected!');

      if (!isDoctor.value) {
        chatRoomName = Common.getChatRoomFormat(
            patientController!.userProfile.value.data!.code!,
            patientController!.detailDoctor.value!.data!.code!);
        patientName = Common.getFormattedName(
            patientController!.userProfile.value.data!.name!);
      } else {
        chatRoomName = Common.getChatRoomFormat(
          doctorController!.selectedFirestoreChat.value.patientID!,
          doctorController!.selectedFirestoreChat.value.doctorID!,
        );
        patientName = Common.getFormattedName(
            doctorController!.selectedFirestoreChat.value.doctorID!);
      }

      currentChatRoom.value = chatRoomName;

      socket.emit('user_join', {
        'username': patientName,
        'room': chatRoomName,
      });

      update();

      EasyLoading.dismiss();

      logger.i('connected: ' + chatRoomName);
    });

    socket.onConnectError((data) {
      FToast().errorToast(data.toString());
      EasyLoading.dismiss();
    });

    socket.on('user_join', (data) {
      if (data['username'] != patientName) {
        FToast().warningToast(data['username'] + ' just joined.');
      }
    });

    socket.on('chat_message', (data) {
      var encodedString = jsonEncode(data);

      Map<String, dynamic> valueMap = json.decode(encodedString);

      ChatItem tempChat = ChatItem.fromJson(valueMap);

      chatList.add(ChatItem(
        message: tempChat.message,
        username: tempChat.username,
        room: tempChat.room,
      ));
      update();

      if (chatScrollController.hasClients) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
        );
      }
    });

    socket.on('file_upload', (data) {
      var encodedString = jsonEncode(data);

      Map<String, dynamic> valueMap = json.decode(encodedString);

      logger.i('FILE UPLOADED DESC : ' + valueMap.toString());

      if (data['message'] == null) {
        if (data['type'] == '.jpg' ||
            data['type'] == '.bmp' ||
            data['type'] == '.png') {
          // var imageURL = UniversalHtml.Url.createObjectUrl(data['file']);
          var imageURL = data['file'];

          chatList.add(ChatItem(
            message: '@!!FILE' + imageURL,
            username: data['username'],
            room: currentChatRoom.value,
          ));
        } else {
          chatList.add(ChatItem(
            message: data['file'],
            username: data['username'],
            room: currentChatRoom.value,
          ));
        }
      }

      // ChatItem tempChat = ChatItem.fromJson(valueMap);
      //
      // logger.i('FILE UPLOADED desc :' + encodedString);
      //
      // var imageURL = UniversalHtml.Url.createObjectUrl(data.file);
      // // var imageURL = '${DartHTML.Url.createObjectUrlFromBlob(DartHTML.Blob(data.file))}';
      //
      // logger.e('imageurl ' + imageURL.toString());
      //
      // chatList.add(ChatItem(
      //   message: imageURL,
      //   username: tempChat.username,
      //   room: tempChat.room,
      // ));
      update();

      // logger.e('imageurl ' + imageURL.split("@!!FILE")[1]);

      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    });

    socket.onError((data) {
      socket.disconnect();
      socket.close();
      FToast()
          .errorToast('Failed Connecting to Chat Server : ' + data.toString());
      EasyLoading.dismiss();
      Get.back();
    });
  }

  void onMoreClicked() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'More',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Container(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: onRequestVideoClicked,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.video_camera_front_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'Request Video Call',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: onAddImageClicked,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.image_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'Add Picture',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Obx(() => isDoctor.value
                ? Container(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(CreateRecipe());
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.receipt_long,
                                color: Colors.black,
                              ),
                              SizedBox(width: 24),
                              Text(
                                'Create Recipe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                : Container()),
            Container(
                padding: const EdgeInsets.only(
                  bottom: 45,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: onEndConversationClicked,
                      child: Row(
                        children: [
                          Icon(
                            Icons.back_hand_rounded,
                            color: colorIndex.primary,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'End This Conversation',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorIndex.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      isScrollControlled: true,
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: true,
      enableDrag: false,
    );
  }

  void onRequestVideoClicked() async {
    String googleUrl = "https://meet.google.com/ecu-txtx-whz";

    if (await canLaunchUrlString(googleUrl)) {
      Get.back();
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      Get.back();
      FToast().errorToast('Failed launching Google Meet');
    }
  }

  void onEndConversationClicked() {
    if(!isDoctor.value ){
      patientController?.onTabNavSelected(0);
      Get.back();
    }
    Get.back();
    Get.back();

    socket.close();
    socket.disconnect();
    socket.emit('end_chat', {});
  }

  void onAddImageClicked() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    DartIO.File image;
    String imagePath;

    if (pickedFile != null) {
      logger.i('image should be uploaded ${pickedFile.path}');
      image = DartIO.File(pickedFile.path);
      imagePath = pickedFile.path;
      final bytes = await image.readAsBytes();
      final size = (await image.readAsBytes()).lengthInBytes;

      socket.emit('file_upload', {
        'name': image.path,
        'type': extension(image.path),
        'size': size,
        'buffer': bytes,
        'data': image.openRead(),
        'file': imagePath,
      });
      Get.back();
    } else {
      print('No image selected.');
    }
  }
}
