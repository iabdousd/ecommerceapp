import 'package:ecommerceapp/src/configs/theme.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:ecommerceapp/src/settings/models.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/dropdown.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  static const routeName = 'settings';
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    return AppScaffold(
      title: Text(AppLocalization.of(context).settings),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: _SettingsCard(
          title: AppLocalization.of(context).generalSettings,
          children: [
            AppDropDown<ThemeBrightness>(
              prefixIcon: const Icon(Icons.light_mode),
              label: AppLocalization.of(context).appearance,
              items: ThemeBrightness.values,
              titleBuilder: (brightness) => Text(brightness.title(context)),
              value: controller.brightness,
              onChanged: controller.setBrightness,
            ),
            AppDropDown<Locale>(
              prefixIcon: const FaIcon(FontAwesomeIcons.language),
              label: AppLocalization.of(context).language,
              items: AppLocalization.supportedLocales,
              titleBuilder: (locale) => Text(locale.title),
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
  final List<Widget> children;
  const _SettingsCard({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.headline6),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
