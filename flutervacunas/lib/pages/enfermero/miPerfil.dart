import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'package:flutter/material.dart';
class miPefilE extends StatefulWidget {
  const miPefilE({super.key});

  @override
  State<miPefilE> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<miPefilE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
      ),
      drawer: const LeftDrawerE(),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Mi perfil, soy enfermero'),
        )
      ),
    );
  }
}