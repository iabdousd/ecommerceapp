import 'package:ecommerceapp/configs/theme.dart';
import 'package:ecommerceapp/l10n/localization.dart';
import 'package:ecommerceapp/settings/controller.dart';
import 'package:ecommerceapp/settings/models.dart';
import 'package:ecommerceapp/shared/widgets/inputs/dropdown.dart';
import 'package:ecommerceapp/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    return AppScaffold(
      title: Text(AppLocalization.of(context).settings),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            AppDropDown<ThemeBrightness>(
              label: AppLocalization.of(context).appearance,
              items: ThemeBrightness.values,
              titleBuilder: (brightness) => Text(brightness.name),
              value: controller.brightness,
              onChanged: controller.setBrightness,
            ),
            AppDropDown<Locale>(
              label: AppLocalization.of(context).appearance,
              items: AppLocalization.supportedLocales,
              titleBuilder: (locale) => Text(locale.toLanguageTag()),
              value: controller.locale,
              onChanged: (newLocale) => controller.locale = newLocale,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final Widget content;
  const _SettingsCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
