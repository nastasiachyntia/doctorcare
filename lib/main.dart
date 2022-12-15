import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/presentation/pages/home/HomeDoctor.dart';
import 'package:doctorcare/presentation/pages/home/HomePatient.dart';
import 'package:doctorcare/presentation/pages/landing/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

void main() async {
  ColorIndex colorIndex = ColorIndex();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colorIndex.primary,
    ),
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
        appBarTheme: AppBarTheme(
          color: colorIndex.primary
        ),
        primaryColor: colorIndex.primary,
      ),
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
