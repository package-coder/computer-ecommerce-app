import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/pages/account_page.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:mobile_app/pages/parts_detail.dart';
import 'package:mobile_app/pages/register_page.dart';
import 'package:mobile_app/pages/service_detail.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: HomePage,
    ),
    AutoRoute(
      path: '/product',
      page: PartsDetailPage,
    ),
    AutoRoute(
      path: '/service',
      page: ServiceDetailPage,
    ),
    AutoRoute(
      path: '/register',
      page: RegisterPage,
    ),
    AutoRoute(
      path: '/account',
      page: AccountPage,
    ),
    AutoRoute(
      path: '/login',
      page: LoginPage,
    ),
  ],
)
class $AppRouter {}
