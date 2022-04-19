import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/src/shared/widgets/icon_button.dart';
import 'package:ecommerceapp/src/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class AppImage extends StatelessWidget {
  final String uri;
  final ImageProvider? placeholderImage;
  final double? width, height;
  final BoxFit? fit;
  final bool zoomable;
  final BorderRadius borderRadius;

  const AppImage({
    Key? key,
    required this.uri,
    this.placeholderImage,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.zoomable = false,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: zoomable
          ? () => context.pushNamed(EnlargedImageScreen.routeName, extra: uri)
          : null,
      child: Hero(
        tag: uri,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: Image(
                image: uri.startsWith('http')
                    ? CachedNetworkImageProvider(uri)
                    : FileImage(File(uri)) as ImageProvider,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;

                  return Stack(
                    children: [
                      if (placeholderImage != null)
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.4),
                            BlendMode.darken,
                          ),
                          child: Image(image: placeholderImage!, fit: fit),
                        )
                      else
                        SizedBox(
                          width: width,
                          height: height,
                          child: const AspectRatio(aspectRatio: 1),
                        ),
                      const Positioned.fill(child: LoadingWidget())
                    ],
                  );
                },
                width: width,
                height: height,
                fit: fit,
              ),
            ),
            if (zoomable)
              const Positioned(
                child: Icon(Icons.open_in_full_rounded),
                top: 10,
                right: 10,
              ),
          ],
        ),
      ),
    );
  }
}

class EnlargedImageScreen extends StatefulWidget {
  static const routeName = 'enlarged-image';

  final String imageUrl;
  const EnlargedImageScreen({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  State<EnlargedImageScreen> createState() => _EnlargedImageScreenState();
}

class _EnlargedImageScreenState extends State<EnlargedImageScreen> {
  bool appBarShown = true;

  @override
  Widget build(BuildContext context) {
    final safeTop = MediaQuery.of(context).padding.top;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => setState(() => appBarShown = !appBarShown),
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.imageUrl),
              heroAttributes: PhotoViewHeroAttributes(tag: widget.imageUrl),
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              minScale: PhotoViewComputedScale.contained,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: Theme.of(context).backgroundColor.withOpacity(
                    appBarShown ? .66 : 0,
                  ),
              height: appBarShown ? safeTop + 50 : 0,
              padding: EdgeInsets.only(top: safeTop),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: context.pop,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
