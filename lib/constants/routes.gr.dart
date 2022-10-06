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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../views/home_view.dart' as _i2;
import '../views/login_view.dart' as _i1;
import '../views/verify_number_view.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginView.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    HomeView.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    VerifyNumberView.name: (routeData) {
      final args = routeData.argsAs<VerifyNumberViewArgs>();
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.VerifyNumberView(
          key: args.key,
          verificationID: args.verificationID,
        ),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          LoginView.name,
          path: '/',
        ),
        _i4.RouteConfig(
          HomeView.name,
          path: '/home-view',
        ),
        _i4.RouteConfig(
          VerifyNumberView.name,
          path: '/verify-number-view',
        ),
      ];
}

/// generated route for
/// [_i1.LoginView]
class LoginView extends _i4.PageRouteInfo<void> {
  const LoginView()
      : super(
          LoginView.name,
          path: '/',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i2.HomeView]
class HomeView extends _i4.PageRouteInfo<void> {
  const HomeView()
      : super(
          HomeView.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i3.VerifyNumberView]
class VerifyNumberView extends _i4.PageRouteInfo<VerifyNumberViewArgs> {
  VerifyNumberView({
    _i5.Key? key,
    required String verificationID,
  }) : super(
          VerifyNumberView.name,
          path: '/verify-number-view',
          args: VerifyNumberViewArgs(
            key: key,
            verificationID: verificationID,
          ),
        );

  static const String name = 'VerifyNumberView';
}

class VerifyNumberViewArgs {
  const VerifyNumberViewArgs({
    this.key,
    required this.verificationID,
  });

  final _i5.Key? key;

  final String verificationID;

  @override
  String toString() {
    return 'VerifyNumberViewArgs{key: $key, verificationID: $verificationID}';
  }
}
