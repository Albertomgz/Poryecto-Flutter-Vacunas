import 'package:flutervacunas/pages/paciente/pacientepage.dart';
import 'package:flutter/material.dart';

import '../../database/mysql.dart';
import '../../widgets/constant.dart';
import '../../widgets/paciente/left_drawerPaciente.dart';

// ignore: must_be_immutable
class PerfilPa extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  String idusuario;
  // ignore: prefer_typing_uninitialized_variables
  String curpUser;
  PerfilPa({super.key, required this.idusuario, required this.curpUser});

  @override
  // ignore: no_logic_in_create_state
  State<PerfilPa> createState() => _PerfilPaState();
}

class _PerfilPaState extends State<PerfilPa> {
  // ignore: prefer_typing_uninitialized_variables

  var db = Mysql();
  String _errorMessage = "";

  TextEditingController curp = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController app = TextEditingController();
  TextEditingController apm = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController password = TextEditingController();

  var Fnombr = "";
  var Fapp = "";
  var Fapm = "";
  var Ffecha = "";
  var Fedad = "";
  var Fsexo = "";
  var Fpass = "";
  var Fcurp = "";
  var Ftipo = "";

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      var results = await conn
          .query('SELECT * FROM usuario where curp=? ', [widget.curpUser]);

      results.forEach((row) {
        Fnombr = row[1];
        Fapp = row[2];
        Fapm = row[3];
        Ffecha = row[4];
        Fsexo = row[5];
        Fedad = row[6].toString();
        Fcurp = row[7];
        Ftipo = row[8];
        Fpass = row[9];
      });
      conn.close();
    });

    curp.text = Fcurp;
    nombre.text = Fnombr;
    app.text = Fapp;
    apm.text = Fapm;
    sex.text = Fsexo;
    fecha.text = Ffecha;
    edad.text = Fedad;
    password.text = Fpass;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
      ),
      drawer: LeftDrawerEPa(
        nombreU: widget.idusuario,
        CURP: widget.curpUser,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
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
                      Form(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: curp,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.search,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Curp',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: nombre,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Nombre',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: app,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.badge,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Apellido paterno',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: apm,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.badge,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Apellido materno',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                    child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: kLightPrimaryColor,
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: TextFormField(
                                    controller: fecha,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.event,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Fecha Nacimiento',
                                        hintStyle:
                                            TextStyle(fontFamily: 'roboto'),
                                        border: InputBorder.none),
                                  ),
                                )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: kLightPrimaryColor,
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: TextFormField(
                                    controller: sex,
                                    cursorColor: kPrimaryColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.group,
                                          color: kPrimaryColor,
                                        ),
                                        hintText: 'Sexo',
                                        hintStyle:
                                            TextStyle(fontFamily: 'roboto'),
                                        border: InputBorder.none),
                                  ),
                                )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: edad,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.badge,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Edad',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                color: kLightPrimaryColor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                controller: password,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: 'Contraseña',
                                    hintStyle: TextStyle(fontFamily: 'roboto'),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: size.width * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: ElevatedButton(
                                  onPressed: () => {
                                    Acualizar(context),
                                  },
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
                                  child: const Text("Guardar",
                                      style: TextStyle(
                                          color: kLightPrimaryColor,
                                          fontSize: 17)),
                                ),
                              ),
                            ),
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
    );
  }

  Acualizar(BuildContext context) {
    _errorMessage = "";
    // ignore: prefer_typing_uninitialized_variables
    var results;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable

    Fnombr = nombre.text;
    Fapp = app.text;
    Fapm = apm.text;
    Fsexo = sex.text;
    Ffecha = fecha.text;
    Fpass = password.text;
    Fcurp = curp.text;

    if (Fnombr.isNotEmpty &&
        Fapp.isNotEmpty &&
        Fapm.isNotEmpty &&
        Ffecha.isNotEmpty &&
        Fsexo.isNotEmpty &&
        Fedad.isNotEmpty &&
        Fpass.isNotEmpty) {
      db.getConnection().then((conn) async {
        results = await conn.query(
            'update usuario set nombre=?,app=?,apm=?,fechaNa=?,sexo=?,edad=?,password=? where curp=?',
            [Fnombr, Fapp, Fapm, Ffecha, Fsexo, Fedad, Fpass, Fcurp]);

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListCampania(
              idusuario: widget.idusuario,
            ),
          ),
        );
      });
    } else {
      setState(() {
        _errorMessage = "Campos vacios porfavor introduzca sus datos";
      });
    }
    Navigator.pop(context);
  }
}
