import 'package:flutervacunas/models/usuario.dart';
import 'package:flutervacunas/pages/enfermero/aceptarAplicacion.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'agregarPaciente.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flutervacunas/widgets/constant.dart';

class ListPacientes extends StatefulWidget {
  const ListPacientes({super.key});

  @override
  State<ListPacientes> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListPacientes> {
  var db = Mysql();
  List<usuario> _model = [];
  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      _model.clear();
      var results =
          await conn.query('SELECT * FROM usuario where tipo="paciente" ');
      results.forEach((row) {
        setState(() {
          usuario u = usuario();
          u.id = row.elementAt(0);
          u.nombre = row.elementAt(1).toString();
          u.aprellidoP = row.elementAt(2).toString();
          u.apellidoM = row.elementAt(3).toString();
          u.sexo = row.elementAt(5).toString();
          u.edad = row.elementAt(6).toString();
          u.curp = row.elementAt(7).toString();
          _model.add(u);
        });
      });
      conn.close();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de pacientes'),
      ),
      drawer: const LeftDrawerE(),
      body: _getBody(context),
    );
  }

  SafeArea _getBody(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Pacientes',
            style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w800,
                fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 700,
            child: _model.length > 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _model.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.all(20),
                          height: 50,
                          child: ListTile(
                            leading: const Icon(
                              Icons.person_pin,
                              color: Colors.blue,
                            ),
                            trailing: Text(
                              '${_model[index].edad} años',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            title: Text('${_model[index].curp}'),
                            subtitle: Text(
                                '${_model[index].nombre} ${_model[index].aprellidoP} ${_model[index].apellidoM}'),
                            onTap: () {
                              _abrirSolicitudes(context, true, index, _model);
                            },
                          ));
                    }))
                : Text('Sin datos')),
      ],
    ));
  }

  void _abrirSolicitudes(BuildContext context, bool fullscreenDialog, int index,
      List<usuario> _model) {
    String idEnfer = _model[index].id.toString();
    print("Se abre solicitud del pacienntescon id? ");
    print(idEnfer);

    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => AceptarAplicacion(idEnfer: idEnfer),
      ),
    );
  }
}
