import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/auth/models.dart';
import 'package:ecommerceapp/src/auth/views/view.dart';
import 'package:ecommerceapp/src/configs/icons.dart';
import 'package:ecommerceapp/src/configs/validators.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/dropdown.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/text_field.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const routeName = '/register';
  static String buildRouteName() => '${AuthView.routeName}/register';

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();
    return AppScaffold(
      addPadding: true,
      safeTop: true,
      body: Form(
        key: controller.authInputModel.registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppIcons.icon,
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Text(
                AppLocalization.of(context).registerTitle,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            AppTextField(
              label: AppLocalization.of(context).fullName,
              prefixIcon: const Icon(Icons.person),
              controller: controller.authInputModel.nameController,
              validator: (value) => FormValidators.name(context, value),
              keyboardType: TextInputType.name,
            ),
            AppDropDown<UserGender>(
              label: AppLocalization.of(context).gender,
              prefixIcon: const Icon(Icons.category),
              items: UserGender.values,
              titleBuilder: (gender) => Text(gender.name(context)),
              value: controller.authInputModel.gender,
              onChanged: (gender) {
                if (gender != null) {
                  controller.authInputModel.gender = gender;
                }
              },
              margin: const EdgeInsets.only(top: 8, bottom: 32),
            ),
            Text(
              AppLocalization.of(context).termsNote,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            AppButton(
              label: AppLocalization.of(context).continueLabel,
              onPressed: () => controller.createAccount(context),
            ),
          ],
        ),
      ),
    );
  }
}
