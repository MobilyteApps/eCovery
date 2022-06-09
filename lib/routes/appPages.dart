import 'package:ecovery/uiModule/myHomePage/views/myHomePage.dart';
import 'package:get/get.dart';

import 'appRoutes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.myHomePage, page: () => MyHomePage()),
  ];
}
