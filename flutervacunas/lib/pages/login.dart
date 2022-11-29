import 'dart:async';

import 'package:flutervacunas/pages/enfermero/pacientes.dart';
import 'package:flutervacunas/pages/medicopage.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flutervacunas/pages/registropage.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/components/componentes.dart';

import '../widgets/constant.dart';
import 'pacientepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variables para base de datos
  var db = Mysql();
  //variable de la clase Mysql variable para guardar el tipo de usuario
  String tipo = '';
  String pass = '';
  String curp = '';

  //Controlares para guardar los valores escritos para las cajas de texto

  late TextEditingController _userCurp;
  late TextEditingController _password;

  //Variable para la execpciones

  String _errorMessage = "";

  //Variables para guardar los valores en tipo string de los controladores y mandarlos como parametros en la consulta de sql

  String usuario = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _userCurp = TextEditingController();
    _password = TextEditingController();
    _errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              const imagenLogo(
                imgnom: 'assets/images/Recurso18.png',
              ),
              const barraTitulo(title: 'Ingresa a tu cuenta'),
              Padding(
                padding: const EdgeInsets.only(top: 320.0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Bienvenido',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w800,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: kLightPrimaryColor,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextFormField(
                                  controller: _userCurp,
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: 'Curp',
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: kLightPrimaryColor,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: TextFormField(
                                  controller: _password,
                                  obscureText: true,
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.lock,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: 'Contraseña',
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              switchListTile(),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: size.width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    onPressed: () => _login(context),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 20),
                                        textStyle: const TextStyle(
                                            letterSpacing: 2,
                                            color: kLightPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans')),
                                    child: const Text("Ingresar",
                                        style: TextStyle(
                                            color: kLightPrimaryColor,
                                            fontSize: 17)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              UnderPart(
                                title: "¿No tienes cuenta?",
                                navigatorText: "Registrate aqui",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Registropage()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validator(String value, String pass) {
    if (value == pass) {
      return true;
    } else {
      return false;
    }
  }

  _login(BuildContext context) {
    setState(() {
      _errorMessage = "";
    });

    usuario = _userCurp.text;
    password = _password.text;

    // ignore: prefer_typing_uninitialized_variables
    var results;

    if (usuario.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Campos vacios porfavor introduzca sus datos";
      });
    } else {
      db.getConnection().then((conn) async {
        results = await conn.query(
            'SELECT tipo,password FROM usuario WHERE curp = ?', [usuario]);

        for (var row in results) {
          tipo = row[0];
          pass = row[1];
        }

        conn.close();
      });

      Timer(const Duration(milliseconds: 700), () {
        if (validator(pass, password)) {
          if (tipo == 'paciente') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListCampania(
                          idusuario: _userCurp.text,
                        )));
          }
          if (tipo == 'enfermero') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListPacientes()));
          }
        } else {
          setState(() {
            _errorMessage =
                "Usuario o contraseña incorrectos, por favor verifique sus credenciales";
          });
        }
      });
    }
  }

  switchListTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 40),
      child: SwitchListTile(
        dense: true,
        title: const Text(
          'Recordarme',
          style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
        ),
        value: true,
        activeColor: kPrimaryColor,
        onChanged: (val) {},
      ),
    );
  }
}

class UnderPart extends StatelessWidget {
  const UnderPart(
      {Key? key,
      required this.title,
      required this.navigatorText,
      required this.onTap})
      : super(key: key);
  final String title;
  final String navigatorText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'roboto',
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            navigatorText,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'roboto'),
          ),
        )
      ],
    );
  }
}
