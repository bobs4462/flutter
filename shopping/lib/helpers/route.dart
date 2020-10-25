import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings routeSettings,
  }) : super(builder: builder, settings: routeSettings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (super.isFirst) {
      return child;
    }
    return FadeTransition(opacity: animation, child: child);
  }
}
