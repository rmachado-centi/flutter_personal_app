import 'package:app/core/constants/application_constants.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final String title;
  final Widget body;
  final Drawer? drawer;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomScaffold({
    Key? key,
    this.scaffoldKey,
    required this.title,
    required this.body,
    this.leading,
    this.actions,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: leading ??
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.amber[800],
                ),
              ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          actions: actions,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: body,
        ),
      ),
    );
  }
}
