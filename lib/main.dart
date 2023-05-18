import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/pages/home/HomeDoctor.dart';
import 'package:doctorcare/presentation/pages/home/HomePatient.dart';
import 'package:doctorcare/presentation/pages/landing/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  ColorIndex colorIndex = ColorIndex();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colorIndex.primary,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  ColorIndex colorIndex = ColorIndex();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor Care',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: colorIndex.primary),
        primaryColor: colorIndex.primary,
        disabledColor: colorIndex.disabled,
      ),
      builder: EasyLoading.init(),
      home: const MyHomePage(title: 'Doctor Care App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AsyncStorage asyncStorage = AsyncStorage();
  ChatFirestoreController chatFirestoreController =
      Get.put(ChatFirestoreController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    var loginState = asyncStorage.isLoggedIn();

    Logger().e(loginState);

    if (loginState == 'doctor') {
      return HomeDoctorScreen();
    } else if (loginState == 'patient') {
      return HomePatientScreen();
    }
    return Role();
  }
}
