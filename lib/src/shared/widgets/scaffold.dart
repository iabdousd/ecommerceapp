import 'package:ecommerceapp/src/configs/theme.dart';
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
  final Widget? drawer, bottomNavigationBar;
  final bool loading, safeTop, hasBackButton, scrollable, addPadding;
  const AppScaffold({
    Key? key,
    this.scaffoldKey,
    this.title,
    this.leading,
    this.actions = const [],
    this.body = const SizedBox.shrink(),
    this.drawer,
    this.bottomNavigationBar,
    this.loading = false,
    this.safeTop = false,
    this.hasBackButton = true,
    this.scrollable = true,
    this.addPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasBackButton =
        this.hasBackButton && !ModalRoute.of(context)!.isFirst;
    final showAppBar = title != null || hasBackButton || leading != null;

    final padding = EdgeInsets.only(
      top: title != null
          ? AppBarTheme.of(context).toolbarHeight! +
              12 +
              kDefaultPadding * (addPadding ? 2 : 1)
          : 0,
      bottom: addPadding ? kDefaultPadding : 0,
      left: addPadding ? kDefaultPadding : 0,
      right: addPadding ? kDefaultPadding : 0,
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: showAppBar
          ? AppBar(
              leading: hasBackButton && leading == null
                  ? AppIconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: context.pop,
                    )
                  : leading,
              title: title,
              leadingWidth: 64,
              centerTitle: true,
              automaticallyImplyLeading: hasBackButton,
            )
          : null,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: safeTop,
        left: false,
        bottom: false,
        right: false,
        child: Stack(
          children: [
            if (loading)
              const Positioned.fill(child: LoadingWidget(darkBackground: true))
            else
              Positioned.fill(
                child: scrollable
                    ? SingleChildScrollView(padding: padding, child: body)
                    : Padding(padding: padding, child: body),
              ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 8,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
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
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
