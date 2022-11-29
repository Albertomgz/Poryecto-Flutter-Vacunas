import 'package:flutervacunas/pages/Registropage.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/pages/login.dart';
import 'package:flutervacunas/pages/enfermero/pacientes.dart';

import 'medicopage.dart';
import 'pacientepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: const LoginPage(),
        routes: <String, WidgetBuilder>{
          '/pacientepage': (BuildContext context) => ListCampania(
                idusuario: '',
              ),
          '/listpacientes': (BuildContext cotext)=> const ListPacientes(),
              '/medicopage': (BuildContext context) => const Medicopage(),
          '/registropage': (BuildContext context) => const Registropage(),
        });
  }
}
