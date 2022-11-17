import 'package:flutervacunas/pages/medicopage.dart';
import 'package:flutervacunas/pages/mysql.dart';
import 'package:flutervacunas/pages/pacientepage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: prefer_final_fields
  bool _loading = false;

  var db = Mysql();
  var tipo = '';
  final user = TextEditingController();
  final password = TextEditingController();

  // ignore: non_constant_identifier_names
  var Stuser = '';
  // ignore: non_constant_identifier_names
  var Stpass = '';

  var prueba = "MAGL990701HPLRNS01";

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
            child: logoVAWidget("assets/images/logoVA.png"),
          ),
          Transform.translate(
            offset: const Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            controller: user,
                            decoration:
                                const InputDecoration(labelText: "Usuario"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: password,
                            decoration:
                                const InputDecoration(labelText: "Constraseña"),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: () => _login(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text("Iniciar Sesion"),
                                  if (_loading)
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("¿No estas registrado?"),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                                child: const Text("Registrarse"),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('');
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

  _login(BuildContext context) {
    Stuser = user.text;
    Stpass = password.text;

    db.getConnection().then((conn) async {
      var results =
          await conn.query('SELECT tipo FROM usuario WHERE curp = ?', [Stuser]);

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
}

Image logoVAWidget(String imagename) {
  return Image.asset(
    imagename,
    height: 300,
  );
}
