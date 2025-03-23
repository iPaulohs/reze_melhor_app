import 'package:flutter/material.dart';

class PesquisaScreen extends StatelessWidget {
  const PesquisaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Center(child: Text("Pesquisa")),
    );
  }
}
