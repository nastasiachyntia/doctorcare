import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:logger/logger.dart';

class ChatScreen extends StatelessWidget {
  ChatController chatController = Get.put(ChatController());
  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  Widget chatRenderer() {
    return ListView.builder(
      itemCount: chatController.chatList.value.length,
      shrinkWrap: true,
      controller: chatController.chatScrollController,
      itemBuilder: (_, index) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: chatController.chatList.value[index].username ==
                  chatController.patientName
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (chatController.chatList.value[index].username ==
                chatController.patientName) ...[
              Container(
                width: 50,
              ),
            ],
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: chatController.chatList.value[index].username ==
                          chatController.patientName
                      ? Colors.white
                      : colorIndex.chatBubble,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Text(chatController.chatList.value[index].message!),
              ),
            ),
            if (chatController.chatList.value[index].username !=
                chatController.patientName) ...[
              Container(
                width: 50,
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => chatController.isScreenLoading.value
          ? Scaffold(
              body: Center(
                child: InkWell(
                  onTap: () => FToast().warningToast('Double Tap to cancel'),
                  onDoubleTap: () => Get.back(),
                  child: CupertinoActivityIndicator(),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                leadingWidth: Get.width,
                leading: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 56,
                      child: IconButton(
                        iconSize: 28,
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          CupertinoIcons.chevron_back,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: Colors.grey),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          chatController.doctorDetail.value.image != null
                              ? chatController.doctorDetail.value.image!
                              : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      chatController.doctorDetail.value!.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Container(
                    color: colorIndex.secondary,
                    height: Get.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: chatRenderer(),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: chatController.chatTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Type Something...',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: colorIndex.primary),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => chatController.onSendMessage(),
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: colorIndex.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
    );
  }
}
