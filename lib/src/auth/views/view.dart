import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/configs/icons.dart';
import 'package:ecommerceapp/src/configs/validators.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/text_field.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();

    return AppScaffold(
      safeTop: true,
      addPadding: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppIcons.icon,
          Text(
            AppLocalization.of(context).authTitle,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          AppTextField(
            fieldKey: controller.authInputModel.phoneFieldKey,
            label: AppLocalization.of(context).phoneNumber,
            controller: controller.authInputModel.phoneNumberController,
            autofocus: true,
            validator: FormValidators.phone(context),
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
            margin: const EdgeInsets.symmetric(vertical: 32),
          ),
          Text(
            AppLocalization.of(context).termsNote,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          AppButton(
            label: AppLocalization.of(context).continueLabel,
            onPressed: () => controller.verifyPhoneNumber(context),
          ),
        ],
      ),
    );
  }
}
