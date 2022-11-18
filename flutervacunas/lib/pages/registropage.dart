// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutervacunas/models/curpmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registropage extends StatefulWidget {
  const Registropage({super.key});

  @override
  State<Registropage> createState() => _RegistropageState();
}

class _RegistropageState extends State<Registropage> {
  final String prueba = "MAGL990701HPLRNS01";

  final curp = TextEditingController();
  final nombre = TextEditingController();
  final app = TextEditingController();
  final apm = TextEditingController();
  final sex = TextEditingController();
  final fecha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
                  // ignore: prefer_const_constructors
                  Color.fromRGBO(79, 195, 247, 1),
                  // ignore: prefer_const_constructors
                  Color.fromRGBO(1, 87, 155, 1),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -100),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 180, bottom: 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: <
                        Widget>[
                      TextFormField(
                        controller: curp,
                        decoration: const InputDecoration(labelText: "CURP"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => getSerivice(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              const Text("Validar Curp"),
                            ],
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: nombre,
                        decoration: const InputDecoration(labelText: "Nombre"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: app,
                        decoration: const InputDecoration(
                            labelText: "Apellido Paterno"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: apm,
                        decoration: const InputDecoration(
                            labelText: "Apellido Materno"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () => getSerivice(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              const Text("Iniciar Sesion"),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("a"),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                            ),
                            child: const Text("Registrarse"),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/registropage');
                            },
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getSerivice(BuildContext context) async {
    var Stcurp = '';

    Stcurp = curp.text;

    final String _urlBase = 'curp-mexico1.p.rapidapi.com';
    final String _host = 'curp-mexico1.p.rapidapi.com';
    final String _apikey = '75b09720a7msh76a0f6707a7d410p1ecbdejsn415e0ad2b0ef';

    final url = Uri.https(
      _urlBase,
      '/porCurp/$Stcurp',
    );
    final response = await http.get(
      url,
      headers: {'X-RapidAPI-Key': _apikey, 'X-RapidAPI-Host': _host},
    );

    final dato = DatosPersonales.fromJson(response.body);
    final nombrecom = dato.datos?.nombre;
    final apellidom = dato.datos?.apellidoMaterno;
    final apellidop = dato.datos?.apellidoPaterno;

    setState(() {
      nombre.text = nombrecom!;
      apm.text = apellidom!;
      app.text = apellidop!;
    });
  }
}
