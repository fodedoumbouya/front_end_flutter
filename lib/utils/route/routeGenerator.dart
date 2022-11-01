import 'package:flutter/material.dart';
import 'package:front_end_flutter/pages/home.dart';
import 'package:front_end_flutter/pages/index.dart';
import 'package:front_end_flutter/pages/login.dart';
import 'package:front_end_flutter/pages/profil.dart';
import 'package:front_end_flutter/pages/signUp.dart';
import 'package:front_end_flutter/utils/route/routeName.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.INDEX:
        return _GeneratePageRoute(
            widget: const Index(), routeName: settings.name ?? "");
      case RoutesName.LOGIN_PAGE:
        return _GeneratePageRoute(
            widget: const Login(), routeName: settings.name ?? "");
      case RoutesName.SIGNUP_PAGE:
        return _GeneratePageRoute(
            widget: const SignUp(), routeName: settings.name ?? "");
      case RoutesName.HOME_PAGE:
        return _GeneratePageRoute(
            widget: const Home(), routeName: settings.name ?? "");
      case RoutesName.PROFIL:
        return _GeneratePageRoute(
            widget: const Profil(), routeName: settings.name ?? "");
      default:
        return _GeneratePageRoute(
            widget: const Login(), routeName: settings.name ?? "");
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                //SlideTransition
                opacity: animation,
                alwaysIncludeSemantics: true,
                // textDirection: TextDirection.rtl,
                // position: Tween<Offset>(
                //   begin: const Offset(1.0, 0.0),
                //   end: Offset.zero,
                // ).animate(animation),
                child: child,
              );
            });
}
