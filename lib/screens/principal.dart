import 'package:flutter/material.dart';

class PrincipalScr extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hola Usuario')),
      body: Center(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Text('Pagina Principal'),
        ),
      ),
    );
  }
}