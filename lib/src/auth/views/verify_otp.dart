import 'package:ecommerceapp/src/auth/views/view.dart';
import 'package:ecommerceapp/src/configs/icons.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../controller.dart';

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({Key? key}) : super(key: key);

  static const routeName = '/verify-otp';
  static String buildRouteName() => '${AuthView.routeName}/verify-otp';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              AppLocalization.of(context).verifyOtpTitle(
                controller.authInputModel.phoneNumberController.text,
              ),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          PinCodeTextField(
            appContext: context,
            onChanged: (value) =>
                context.read<AuthController>().authInputModel.smsCode = value,
            length: 6,
            textStyle: Theme.of(context).textTheme.subtitle1,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme.defaults(
              inactiveColor: Theme.of(context).colorScheme.onBackground,
              activeColor: Theme.of(context).primaryColor,
              fieldHeight: 64,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(AppLocalization.of(context).resendOtp),
            ),
          ),
          AppButton(
            label: AppLocalization.of(context).continueLabel,
            onPressed: () => controller.verifySmsCode(context),
          ),
        ],
      ),
    );
  }
}
