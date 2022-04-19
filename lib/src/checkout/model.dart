import 'package:ecommerceapp/src/configs/icons.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';

enum PaymentMethod { bankily, masrivi, cashOnDelivery }

extension PaymentMethodExt on PaymentMethod {
  String get title {
    switch (this) {
      case PaymentMethod.bankily:
        return AppLocalization.instance.bankily;
      case PaymentMethod.masrivi:
        return AppLocalization.instance.masrivi;
      case PaymentMethod.cashOnDelivery:
        return AppLocalization.instance.cashOnDelivery;
    }
  }

  AppIcon get icon {
    switch (this) {
      case PaymentMethod.bankily:
        return AppIcons.bankily;
      case PaymentMethod.masrivi:
        return AppIcons.masrivi;
      case PaymentMethod.cashOnDelivery:
        return AppIcons.cashOnDelivery;
    }
  }
}
