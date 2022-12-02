// ignore_for_file: file_names

import 'package:flutervacunas/models/curpmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/mysql.dart';
import '../widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Registropage extends StatefulWidget {
  const Registropage({super.key});

  @override
  State<Registropage> createState() => _RegistropageState();
}

// ignore: camel_case_types
enum usuarios { paciente, enfermero }

class _RegistropageState extends State<Registropage> {
  var db = Mysql();

  String _errorMessageCurp = "";
  String _errorMessage = "";

  final curp = TextEditingController();
  final nombre = TextEditingController();
  final app = TextEditingController();
  final apm = TextEditingController();
  final sex = TextEditingController();
  final fecha = TextEditingController();
  final password = TextEditingController();

  usuarios? _usuarios;

  // ignore: non_constant_identifier_names
  String Fnombr = "";
  // ignore: non_constant_identifier_names
  String Fapp = "";
  // ignore: non_constant_identifier_names
  String Fapm = "";
  // ignore: non_constant_identifier_names
  String Ffecha = "";
  // ignore: non_constant_identifier_names
  String Fsexo = "";
  // ignore: non_constant_identifier_names
  String Fpass = "";
  // ignore: non_constant_identifier_names
  String Fcurp = "";

  double edad = 0;
  int edadentero = 0;

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
              const background(),
              const cardBackground(title: 'Registrate'),
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
                        const SizedBox(
                          height: 20,
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
                                  controller: curp,
                                  cursorColor: kPrimaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.search,
                                        color: kPrimaryColor,
                                      ),
                                      hintText: 'Buscar Curp',
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: size.width * 0.5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    onPressed: () => getSerivice(context),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 15),
                                        textStyle: const TextStyle(
                                            letterSpacing: 2,
                                            color: kLightPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans')),
                                    child: const Text("Validar Curp",
                                        style: TextStyle(
                                            color: kLightPrimaryColor,
                                            fontSize: 17)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  _errorMessageCurp,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                      child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                                        horizontal: 10, vertical: 0),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
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
                                      hintStyle:
                                          TextStyle(fontFamily: 'roboto'),
                                      border: InputBorder.none),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: RadioListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 0),
                                      value: usuarios.paciente,
                                      groupValue: _usuarios,
                                      title: const Text("Paciente"),
                                      onChanged: (usuarios? value) {
                                        setState(() {
                                          _usuarios = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 0),
                                      value: usuarios.enfermero,
                                      groupValue: _usuarios,
                                      title: const Text("Enfemero"),
                                      onChanged: (usuarios? value) {
                                        setState(() {
                                          _usuarios = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: size.width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    onPressed: () => Registrar(context),
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
                                    child: const Text("Registrar",
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

  Future getSerivice(BuildContext context) async {
    // ignore: non_constant_identifier_names
    var Stcurp = '';
    _errorMessageCurp = '';
    Stcurp = curp.text;

    if (Stcurp.isNotEmpty) {
      if (Stcurp.length == 18) {
        // ignore: no_leading_underscores_for_local_identifiers, prefer_const_declarations
        final String _urlBase = 'curp-mexico1.p.rapidapi.com';
        // ignore: no_leading_underscores_for_local_identifiers, prefer_const_declarations
        final String _host = 'curp-mexico1.p.rapidapi.com';
        // ignore: no_leading_underscores_for_local_identifiers, prefer_const_declarations
        final String _apikey =
            '9a610294camsh5338e9b85054dd7p17c68fjsn7ddd798810be';

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
        final sexo = dato.datos?.sexo;
        DateTime? fechaNa = dato.datos?.fechaNacimiento;

        String date = DateFormat("yyyy-MM-dd").format(fechaNa!);

        edad = calculdaredad(fechaNa);
        edadentero = edad.toInt();

        setState(() {
          nombre.text = nombrecom!;
          apm.text = apellidom!;
          app.text = apellidop!;
          sex.text = sexo!;
          fecha.text = date;
        });
      } else {
        setState(() {
          _errorMessageCurp = "Curp invalido, verifique la longitud del Curp";
        });
      }
    } else {
      setState(() {
        _errorMessageCurp = "Campos vacios porfavor introduzca sus datos";
      });
    }
  }

  // ignore: non_constant_identifier_names
  Registrar(BuildContext context) {
    _errorMessage = "";
    // ignore: prefer_typing_uninitialized_variables
    var results;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var results2;

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
        Fpass.isNotEmpty) {
      if (_usuarios == usuarios.paciente) {
        String tipo1 = "paciente";

        db.getConnection().then((conn) async {
          results = await conn.query(
              'insert into usuario (nombre,app,apm,fechaNa,sexo,edad,curp,tipo,password) values (?,?,?,?,?,?,?,?,?)',
              [
                Fnombr,
                Fapp,
                Fapm,
                Ffecha,
                Fsexo,
                edadentero,
                Fcurp,
                tipo1,
                Fpass
              ]);

          //print("New user's id: ${results.insertId}");
          String iduser = "${results.insertId}";
          int idaciente = int.parse(iduser);
          results2 = await conn.query(
              'insert into paciente (idusuario ) values (?)', [idaciente]);

          //print("New user's id: ${results2.insertId}");
          Navigator.pop(context);
        });
      } else {
        String tipo2 = "enfermero";
        db.getConnection().then((conn) async {
          results = await conn.query(
              'insert into usuario (nombre,app,apm,fechaNa,sexo,edad,curp,tipo,password) values (?,?,?,?,?,?,?,?,?)',
              [
                Fnombr,
                Fapp,
                Fapm,
                Ffecha,
                Fsexo,
                edadentero,
                Fcurp,
                tipo2,
                Fpass
              ]);

          //print("New user's id: ${results.insertId}");

          String iduser2 = "${results.insertId}";
          int idenfermero = int.parse(iduser2);
          results2 = await conn.query(
              'insert into enfermero (idusuario ) values (?)', [idenfermero]);

          //print("New user's id: ${results2.insertId}");

          Navigator.pop(context);
        });
      }
    } else {
      setState(() {
        _errorMessage = "Campos vacios porfavor introduzca sus datos";
      });
    }
  }
}

calculdaredad(DateTime fecha) {
  DateTime datenow = DateTime.now();
  int days = datenow.difference(fecha).inDays;
  double age = (days / 365).roundToDouble();

  return age;
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

// ignore: camel_case_types
class background extends StatelessWidget {
  const background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: kPrimaryColor,
        ),
        iconBackButton(context),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

// ignore: camel_case_types
class cardBackground extends StatelessWidget {
  const cardBackground({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: kLightPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'roboto',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                // ignore: use_full_hex_values_for_flutter_colors
                color: Color(0xfff575861)),
          ),
        ),
      ),
    );
  }
}
