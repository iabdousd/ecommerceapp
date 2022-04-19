import 'package:ecommerceapp/src/configs/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.emptyView,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              message,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
