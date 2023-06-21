import 'package:auto_route/auto_route.dart';
import 'package:mobile_app/pages/account_page.dart';
import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/initialize_shop_page.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:mobile_app/pages/register_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: HomePage,
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
    AutoRoute(
      path: '/shop',
      page: InitShopPage
    )
  ],
)
class $AppRouter {}
