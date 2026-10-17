import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../sd_router_helper_v5/sd_router_helper_v5.dart';

class SdGoRouteV5 extends GoRoute {
  SdGoRouteV5({
    required super.path,
    required String super.name,
    required Widget Function(BuildContext, GoRouterState) super.builder,
    super.routes,
    super.parentNavigatorKey,
    bool withSlideTransition = true,
  }) : super(
         pageBuilder: (context, state) {
           final child = builder(context, state);
           if (withSlideTransition && Platform.isAndroid) {
             return SdRouterHelperV5.buildSlideTransitionPage(
               child: child,
               state: state,
             );
           } else {
             return MaterialPage(key: state.pageKey, child: child);
           }
         },
       );
}
