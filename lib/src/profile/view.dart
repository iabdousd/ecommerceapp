import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/settings/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const userName = 'Not registered';

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: CircleAvatar(radius: 64),
              ),
              Text(userName, style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        ListTile(
          title: Text(AppLocalization.of(context).settings),
          leading: const Icon(Icons.settings),
          onTap: () => context.go(SettingsView.buildRouteName()),
        ),
        ListTile(
          title: Text(AppLocalization.of(context).signOut),
          leading: const Icon(Icons.logout),
          onTap: () => context.read<AuthController>().logout(context),
        ),
      ],
    );
  }
}
