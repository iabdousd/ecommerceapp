import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool darkBackground;
  const LoadingWidget({Key? key, this.darkBackground = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          darkBackground ? Theme.of(context).shadowColor.withOpacity(.5) : null,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
