import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final EdgeInsets margin;
  const UserAvatar({
    Key? key,
    this.avatarUrl,
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: CircleAvatar(
        radius: 64,
        foregroundImage:
            avatarUrl != null ? CachedNetworkImageProvider(avatarUrl!) : null,
        child: avatarUrl == null
            ? const FaIcon(FontAwesomeIcons.userAstronaut, size: 64)
            : null,
      ),
    );
  }
}
