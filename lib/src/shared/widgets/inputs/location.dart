import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/shared/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationField extends StatefulWidget {
  final String label;
  final Position? value;
  final ValueChanged<Position?>? onChanged;
  final FormFieldValidator<Position>? validator;
  final EdgeInsets margin;

  const LocationField({
    Key? key,
    required this.label,
    this.value,
    this.onChanged,
    this.validator,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  final _key = GlobalKey<FormFieldState>();
  String? address;

  void _onTap() async {
    try {
      EasyLoading.show();
      await Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition();
      final placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      EasyLoading.dismiss();

      address = placeMarks.isNotEmpty
          ? '${placeMarks.first.name}, ${placeMarks.first.street}'
          : '${position.latitude}, ${position.longitude}';

      _key.currentState!.didChange(position);
      if (widget.onChanged != null) widget.onChanged!(position);
    } catch (e) {
      //
    }
  }

  void _onDelete() {
    address = null;
    _key.currentState!.didChange(null);
    if (widget.onChanged != null) widget.onChanged!(null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: FormField<Position>(
        key: _key,
        validator: widget.validator,
        initialValue: widget.value,
        builder: (state) => GestureDetector(
          onTap: _onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: Colors.black26),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            address ?? AppLocalization.of(context).pickLocation,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                      if (state.value != null)
                        AppIconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).errorColor,
                            size: 20,
                          ),
                          onPressed: _onDelete,
                          margin: EdgeInsets.zero,
                        ),
                    ],
                  ),
                ),
                if (state.value == null && state.hasError)
                  Text(
                    state.errorText!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).errorColor,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
