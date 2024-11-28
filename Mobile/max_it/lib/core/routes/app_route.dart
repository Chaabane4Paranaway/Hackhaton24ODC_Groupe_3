import 'package:get/get.dart';
import 'package:max_it/core/routes/route.dart';
import 'package:max_it/main.dart';
import 'package:max_it/presentation/pages/debloqueAccount.dart';
import 'package:max_it/presentation/pages/home.dart';

class Routes {
  static final routes = [
    GetPage(
      name: MyRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: MyRoutes.unlock,
      page: () => const UnlockAccountPage(),
    ),
  ];
}
