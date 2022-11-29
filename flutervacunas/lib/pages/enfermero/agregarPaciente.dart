import 'package:flutter/material.dart';
class AgregarPaciente extends StatefulWidget {
  const AgregarPaciente({super.key});

  @override
  State<AgregarPaciente> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AgregarPaciente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regitro nuevo paciente'),
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('AgregarPAciente, soy enfermero'),
        )
      ),
    );
  }
}