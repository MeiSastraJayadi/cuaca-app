import 'package:flutter/material.dart';

Route getRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curves = Curves.ease;
      final tween =
          Tween(end: end, begin: begin).chain(CurveTween(curve: curves));
      final animateTransition = animation.drive(tween);

      return SlideTransition(
        position: animateTransition,
        child: child,
      );
    },
  );
}
