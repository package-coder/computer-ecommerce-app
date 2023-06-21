// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../pages/account_page.dart' as _i3;
import '../pages/home_page.dart' as _i1;
import '../pages/initialize_shop_page.dart' as _i5;
import '../pages/login_page.dart' as _i4;
import '../pages/register_page.dart' as _i2;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AccountPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    InitShopRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.InitShopPage(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i6.RouteConfig(
          AccountRoute.name,
          path: '/account',
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i6.RouteConfig(
          InitShopRoute.name,
          path: '/shop',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.AccountPage]
class AccountRoute extends _i6.PageRouteInfo<void> {
  const AccountRoute()
      : super(
          AccountRoute.name,
          path: '/account',
        );

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.InitShopPage]
class InitShopRoute extends _i6.PageRouteInfo<void> {
  const InitShopRoute()
      : super(
          InitShopRoute.name,
          path: '/shop',
        );

  static const String name = 'InitShopRoute';
}
