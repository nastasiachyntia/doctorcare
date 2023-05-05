import 'dart:convert';
import 'dart:io' as DartIO;

import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Chat/ChatModel.dart';
import 'package:doctorcare/data/models/home/DoctorDetailResponse.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:universal_html/html.dart' as UniversalHtml;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  HomePatientController patientController = Get.find();

  ColorIndex colorIndex = ColorIndex();

  var doctorDetail = Data().obs;
  var isScreenLoading = true.obs;
  var logger = Logger();
  var chatList = <ChatItem>[].obs;
  final _picker = ImagePicker();
  var currentChatRoom = ''.obs;

  late final IO.Socket socket;
  TextEditingController chatTextController = TextEditingController();
  ScrollController chatScrollController = ScrollController();

  var chatRoomName;
  var patientName;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    doctorDetail.value = patientController.detailDoctor.value!.data!;
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

  void onSocketInitalize() {
    _onLoading();
    socket = IO.io('https://doctorcare.site', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
  }

  void socketListener() {
    socket.onConnect((_) {
      isScreenLoading.value = false;
      FToast().successToast('Connected!');
      chatRoomName = Common.getChatRoomFormat(
          patientController.userProfile.value.data!.name!,
          patientController.detailDoctor.value!.data!.name!);
      patientName = Common.getFormattedName(
          patientController.userProfile.value.data!.name!);

      currentChatRoom.value = chatRoomName;

      socket.emit('user_join', {
        'username': patientName,
        'room': chatRoomName,
      });

      update();

      dialogClose();
      logger.i('connected: ' + chatRoomName);
    });

    socket.onConnectError((data) => FToast().errorToast(data.toString()));

    socket.on('user_join', (data) {
      if (data['username'] !=
          Common.getFormattedName(
              patientController.userProfile.value.data!.name!)) {
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

      chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
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
      dialogClose();
      dialogClose();
    });
  }

  void _onLoading() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CupertinoActivityIndicator(
          color: Colors.white,
          radius: 24,
        );
      },
    );
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
                    onPressed: dialogClose,
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
                      onTap: onAddFileClicked,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.file_present_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'Add Document',
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
    String googleUrl = "https://meet.google.com/oyq-egzo-zqy";

    if (await canLaunchUrlString(googleUrl)) {
      dialogClose();
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      dialogClose();
      FToast().errorToast('Failed launching Google Meet');
    }
  }

  void onAddFileClicked() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: "Pick File",
      type: FileType.any,
    );

    if (result != null) {
      logger.i('File should be uploaded ', result.files[0].path);
      // File file = File(result.files.single.path!);

      socket.emit('file_upload', {
        'name': result.files[0].path,
        'type': extension(result.files.single.path!),
        'size': result.files[0].size,
        'buffer': result.files[0].bytes,
        'data': '-',
        'file': result.files.single.path!,
      });
      dialogClose();
    } else {
      // User canceled the picker
    }
  }

  void onEndConversationClicked() {
    dialogClose();
    dialogClose();
    socket.close();
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
        'data': '-',
        'file': imagePath,
      });
      dialogClose();
    } else {
      print('No image selected. dasd');
    }
  }

  void dialogClose() {
    Get.back();
  }
}
