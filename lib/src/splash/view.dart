import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/configs/icons.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  static const routeName = '/';
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthController>().init(context);

    return const AppScaffold(
      scrollable: false,
      body: Center(child: AppIcons.icon),
    );
  }
}
