import 'package:flutervacunas/pages/medicopage.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flutervacunas/pages/pacientepage.dart';
import 'package:flutervacunas/pages/registropage.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/components/componentes.dart';

import '../widgets/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variables para base de datos
  var db = Mysql(); //variable de la clase Mysql
  var tipo = ''; //variable para guardar el tipo de usuario

  //Controlares para guardar los valores escritos para las cajas de texto

  late TextEditingController _userCurp;
  late TextEditingController _password;

  //Variables para guardar los valores en tipo string de los controladores y mandarlos como parametros en la consulta de sql

  var usuario = '';
  var password = '';
  var prueba = "MAGL990701HPLRNS01";

  @override
  void initState() {
    super.initState();
    _userCurp = TextEditingController();
    _password = TextEditingController();
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

  _login(BuildContext context) {
    usuario = _userCurp.text;
    password = _password.text;

    db.getConnection().then((conn) async {
      var results = await conn
          .query('SELECT tipo FROM usuario WHERE curp = ?', [usuario]);

      for (var row in results) {
        tipo = row[0];
      }
    });

    if (tipo == 'paciente') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Pacientepage()));
    }
    if (tipo == 'enfermero') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Medicopage()));
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
