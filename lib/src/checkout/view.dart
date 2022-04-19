import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/cart/controller.dart';
import 'package:ecommerceapp/src/checkout/model.dart';
import 'package:ecommerceapp/src/configs/validators.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/image.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/location.dart';
import 'package:ecommerceapp/src/shared/widgets/inputs/text_field.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  static const routeName = 'checkout';
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CartController>();
    final selectedMethod = context.select<CartController, PaymentMethod>(
      (controller) => controller.paymentMethod,
    );

    return AppScaffold(
      title: Text(AppLocalization.of(context).checkout),
      addPadding: true,
      body: Form(
        key: controller.checkoutFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  AppLocalization.of(context).selectPaymentMethod,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              for (final method in PaymentMethod.values)
                _PaymentMethodWidget(
                  selectedMethod: selectedMethod,
                  method: method,
                ),
              if (selectedMethod == PaymentMethod.bankily)
                const _BankilyFormFields()
              else if (selectedMethod == PaymentMethod.masrivi)
                const _MasriviFormFields()
              else if (selectedMethod == PaymentMethod.cashOnDelivery)
                const _CashOnDeliveryFormFields(),
              AppTextField(
                label: AppLocalization.of(context).note,
                onChanged: (newVal) => controller.note = newVal,
                minLines: 3,
                maxLines: null,
              ),
              AppButton(
                label: AppLocalization.instance.checkout,
                margin: const EdgeInsets.only(top: 32),
                onPressed: () => controller.checkout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodWidget extends StatelessWidget {
  final PaymentMethod method, selectedMethod;
  const _PaymentMethodWidget({
    Key? key,
    required this.method,
    required this.selectedMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = selectedMethod == method;
    final surface = Theme.of(context).colorScheme.surface;

    return GestureDetector(
      onTap: () => context.read<CartController>().paymentMethod = method,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected
              ? Color.lerp(surface, Theme.of(context).primaryColor, .1)
              : surface,
          border: Border.all(
            color:
                selected ? Theme.of(context).primaryColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 6),
        height: 80,
        child: Row(
          children: [
            method.icon.apply(
              padding: const EdgeInsets.only(right: 12),
              size: 80,
            ),
            Text(
              method.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}

class _BankilyFormFields extends StatelessWidget {
  const _BankilyFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CartController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 8),
          child: Text(
            AppLocalization.of(context).bankilyInstructions(controller.total),
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ),
        AppTextField(
          label: AppLocalization.of(context).phoneNumber,
          keyboardType: TextInputType.phone,
          validator: FormValidators.phone(context),
          initialValue: context.read<AuthController>().user.phoneNumber,
          onChanged: (newVal) => controller.phoneNumber = newVal,
        ),
        ImageField(
          label: AppLocalization.of(context).transactionImage,
          validator: FormValidators.objectRequired(context),
          onChanged: (newVal) => controller.transactionImage = newVal,
        ),
      ],
    );
  }
}

class _MasriviFormFields extends StatelessWidget {
  const _MasriviFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CartController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 8),
          child: Text(
            AppLocalization.of(context).masriviInstructions(controller.total),
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ),
        AppTextField(
          label: AppLocalization.of(context).phoneNumber,
          keyboardType: TextInputType.phone,
          validator: FormValidators.phone(context),
          initialValue: context.read<AuthController>().user.phoneNumber,
          onChanged: (newVal) => controller.phoneNumber = newVal,
        ),
        ImageField(
          label: AppLocalization.of(context).transactionImage,
          validator: FormValidators.objectRequired(context),
          onChanged: (newVal) => controller.transactionImage = newVal,
        ),
      ],
    );
  }
}

class _CashOnDeliveryFormFields extends StatelessWidget {
  const _CashOnDeliveryFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CartController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 8),
          child: Text(
            AppLocalization.of(context).masriviInstructions(controller.total),
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
        ),
        AppTextField(
          label: AppLocalization.of(context).phoneNumber,
          keyboardType: TextInputType.phone,
          validator: FormValidators.phone(context),
          initialValue: context.read<AuthController>().user.phoneNumber,
          onChanged: (newVal) => controller.phoneNumber = newVal,
        ),
        LocationField(
          label: AppLocalization.of(context).myLocation,
          validator: FormValidators.objectRequired(context),
          onChanged: (newVal) => controller.location = newVal,
        ),
      ],
    );
  }
}
