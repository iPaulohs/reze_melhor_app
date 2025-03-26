import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HojeScreen extends StatelessWidget {
  const HojeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(child: Text(""))
      ),
    );
  }
}

class FullScreenDialogPage extends StatelessWidget {
  const FullScreenDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 700,
      decoration: BoxDecoration(color: CupertinoColors.lightBackgroundGray),
      child: Center(child: Text("Full Screen Dialog.")),
    );
  }
}
