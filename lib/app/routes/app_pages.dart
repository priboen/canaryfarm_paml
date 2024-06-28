import 'package:get/get.dart';

import 'package:royal_canary_farm_app/app/modules/canarydetail/bindings/canarydetail_binding.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/views/canarydetail_view.dart';
import 'package:royal_canary_farm_app/app/modules/canaryupdate/bindings/canaryupdate_binding.dart';
import 'package:royal_canary_farm_app/app/modules/canaryupdate/views/canaryupdate_view.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/bindings/chicksdetail_binding.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/views/chicksdetail_view.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/bindings/chickslist_binding.dart';
import 'package:royal_canary_farm_app/app/modules/chickslist/views/chickslist_view.dart';
import 'package:royal_canary_farm_app/app/modules/transaction/bindings/transaction_binding.dart';
import 'package:royal_canary_farm_app/app/modules/transaction/views/transaction_view.dart';
import 'package:royal_canary_farm_app/app/modules/transactiondetail/bindings/transactiondetail_binding.dart';
import 'package:royal_canary_farm_app/app/modules/transactiondetail/views/transactiondetail_view.dart';
import 'package:royal_canary_farm_app/app/modules/transactionlist/bindings/transactionlist_binding.dart';
import 'package:royal_canary_farm_app/app/modules/transactionlist/views/transactionlist_view.dart';

import '../modules/canary/bindings/canary_binding.dart';
import '../modules/canary/views/canary_view.dart';
import '../modules/canarylist/bindings/canarylist_binding.dart';
import '../modules/canarylist/views/canarylist_view.dart';
import '../modules/chicks/bindings/chicks_binding.dart';
import '../modules/chicks/views/chicks_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CANARY,
      page: () => CanaryView(),
      binding: CanaryBinding(),
    ),
    GetPage(
      name: _Paths.CHICKS,
      page: () => const ChicksView(),
      binding: ChicksBinding(),
    ),
    GetPage(
      name: _Paths.CANARYLIST,
      page: () => const CanarylistView(),
      binding: CanarylistBinding(),
    ),
    GetPage(
      name: _Paths.CANARYDETAIL,
      page: () => CanarydetailView(),
      binding: CanarydetailBinding(),
    ),
    GetPage(
      name: _Paths.CANARYUPDATE,
      page: () => CanaryupdateView(),
      binding: CanaryupdateBinding(),
    ),
    GetPage(
      name: _Paths.CHICKSLIST,
      page: () => ChickslistView(),
      binding: ChickslistBinding(),
    ),
    GetPage(
      name: _Paths.CHICKSDETAIL,
      page: () => ChicksdetailView(),
      binding: ChicksdetailBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONLIST,
      page: () => TransactionlistView(),
      binding: TransactionlistBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONDETAIL,
      page: () => TransactiondetailView(),
      binding: TransactiondetailBinding(),
    ),
  ];
}
