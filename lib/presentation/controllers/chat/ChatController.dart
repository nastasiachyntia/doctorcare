import 'dart:convert';
import 'dart:io';

import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Chat/ChatModel.dart';
import 'package:doctorcare/data/models/home/DoctorDetailResponse.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  HomePatientController patientController = Get.find();
  var doctorDetail = Data().obs;
  var isScreenLoading = true.obs;
  var logger = Logger();
  var chatList = <ChatItem>[].obs;

  late final IO.Socket socket;
  TextEditingController chatTextController = TextEditingController();
  ScrollController chatScrollController = ScrollController();

  late final chatRoomName;
  late final patientName;

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
    logger.e('disconnected');
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
      FToast().successToast('Connected!');
      chatRoomName = Common.getChatRoomFormat(
          patientController.userProfile.value.data!.name!,
          patientController.detailDoctor.value!.data!.name!);
      patientName = Common.getFormattedName(
          patientController.userProfile.value.data!.name!);
      socket.emit('user_join', {
        'username': patientName,
        'room': chatRoomName,
      });
      dialogClose();
      logger.e('connected: ' + chatRoomName);
    });
    socket.onConnectError(
        (data) => logger.e('onconnecterror ' + data.toString()));

    socket.on('event', (data) => logger.e('data ' + data.toString()));
    socket.on('fromServer', (_) => logger.e('fromserver'));
    socket.on('user_join', (data) {
      FToast().warningToast('Just Joined : ' + data.toString());
    });
    socket.on('chat_message', (data) {
      logger.e(data.toString());

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

  void dialogClose() {
    Get.back();
  }
}
