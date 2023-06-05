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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../pages/account_page.dart' as _i5;
import '../pages/home_page.dart' as _i1;
import '../pages/login_page.dart' as _i6;
import '../pages/parts_detail.dart' as _i2;
import '../pages/register_page.dart' as _i4;
import '../pages/service_detail.dart' as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    PartsDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PartsDetailRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.PartsDetailPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ServiceDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceDetailRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ServiceDetailPage(
          key: args.key,
          serviceId: args.serviceId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.AccountPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          PartsDetailRoute.name,
          path: '/product',
        ),
        _i7.RouteConfig(
          ServiceDetailRoute.name,
          path: '/service',
        ),
        _i7.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i7.RouteConfig(
          AccountRoute.name,
          path: '/account',
        ),
        _i7.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.PartsDetailPage]
class PartsDetailRoute extends _i7.PageRouteInfo<PartsDetailRouteArgs> {
  PartsDetailRoute({
    _i8.Key? key,
    required int productId,
  }) : super(
          PartsDetailRoute.name,
          path: '/product',
          args: PartsDetailRouteArgs(
            key: key,
            productId: productId,
          ),
        );

  static const String name = 'PartsDetailRoute';
}

class PartsDetailRouteArgs {
  const PartsDetailRouteArgs({
    this.key,
    required this.productId,
  });

  final _i8.Key? key;

  final int productId;

  @override
  String toString() {
    return 'PartsDetailRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i3.ServiceDetailPage]
class ServiceDetailRoute extends _i7.PageRouteInfo<ServiceDetailRouteArgs> {
  ServiceDetailRoute({
    _i8.Key? key,
    required int serviceId,
  }) : super(
          ServiceDetailRoute.name,
          path: '/service',
          args: ServiceDetailRouteArgs(
            key: key,
            serviceId: serviceId,
          ),
        );

  static const String name = 'ServiceDetailRoute';
}

class ServiceDetailRouteArgs {
  const ServiceDetailRouteArgs({
    this.key,
    required this.serviceId,
  });

  final _i8.Key? key;

  final int serviceId;

  @override
  String toString() {
    return 'ServiceDetailRouteArgs{key: $key, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.AccountPage]
class AccountRoute extends _i7.PageRouteInfo<void> {
  const AccountRoute()
      : super(
          AccountRoute.name,
          path: '/account',
        );

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}
