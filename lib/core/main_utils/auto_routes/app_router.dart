import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/screens/informations_screen.dart';
import 'package:business_manager/core/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends RootStackRouter{
  @override
  List<AutoRoute> get routes => [
  AutoRoute(page: InformationsRoute.page),
    AutoRoute(page: SignInRoute.page),
  ];
}