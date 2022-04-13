import 'package:ecommerceapp/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'icon_button.dart';
import 'loading.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? title;
  final Widget? leading;
  final List<Widget> actions;
  final Widget body;
  final Widget? drawer;
  final bool loading, safeTop, hasBackButton, scrollable;
  const AppScaffold({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.leading,
    this.actions = const [],
    this.body = const SizedBox.shrink(),
    this.drawer,
    this.loading = false,
    this.safeTop = false,
    this.hasBackButton = true,
    this.scrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(
      top: title != null
          ? AppBarTheme.of(context).toolbarHeight ??
              kToolbarHeight + kDefaultPadding
          : 0,
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: hasBackButton && !ModalRoute.of(context)!.isFirst
            ? leading ??
                AppIconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: context.pop,
                )
            : leading,
        title: title,
        centerTitle: true,
        automaticallyImplyLeading: hasBackButton,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: safeTop,
        left: false,
        bottom: false,
        right: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: scrollable
                  ? SingleChildScrollView(padding: padding, child: body)
                  : Padding(padding: padding, child: body),
            ),
            if (loading)
              const Positioned.fill(child: LoadingWidget(darkBackground: true)),
          ],
        ),
      ),
      drawer: drawer != null
          ? Container(
              color: Theme.of(context).colorScheme.surface,
              child: drawer,
              width: MediaQuery.of(context).size.width * .75,
            )
          : null,
    );
  }
}
