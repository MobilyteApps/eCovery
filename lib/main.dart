import 'package:ecovery/routes/appPages.dart';
import 'package:ecovery/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.myHomePage,
      debugShowCheckedModeBanner: false,
    );
  }
}
