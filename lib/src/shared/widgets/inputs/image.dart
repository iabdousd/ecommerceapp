import 'dart:io';

import 'package:ecommerceapp/src/shared/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final String label;
  final File? value;
  final ValueChanged<File?>? onChanged;
  final FormFieldValidator<File>? validator;
  final EdgeInsets margin;

  const ImageField({
    Key? key,
    required this.label,
    this.value,
    this.onChanged,
    this.validator,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  final _key = GlobalKey<FormFieldState>();

  void _onTap() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (picked != null) {
      final newValue = File(picked.path);
      _key.currentState!.didChange(newValue);
      if (widget.onChanged != null) widget.onChanged!(newValue);
    }
  }

  void _onDelete() {
    _key.currentState!.didChange(null);
    if (widget.onChanged != null) widget.onChanged!(null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: FormField<File>(
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: state.value != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                state.value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: AppIconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).errorColor,
                                  size: 20,
                                ),
                                onPressed: _onDelete,
                              ),
                            ),
                          ],
                        )
                      : const Icon(Icons.add_a_photo_rounded, size: 40),
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
