import 'package:flutervacunas/models/usuario.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'agregarPaciente.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/database/mysql.dart';

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
      await conn
          .query('SELECT * FROM pbdvacuna.usuario where tipo="paciente" ')
          .then((value) {
        value.forEach((row) {
          usuario u = usuario();
          u.nombre = row.elementAt(1).toString();
          u.aprellidoP = row.elementAt(2).toString();
          u.apellidoM = row.elementAt(3).toString();
          u.curp = row.elementAt(4).toString();
          _model.add(u);
        });
      });
      /*for (var row in results) {
        tipo = row[0];
      }*/
      print('Valores---->');
      print(_model[0]);
      print('Tamaño map de usuarios pacientes---->');
      print(_model.length);
      // Finally, close the connection
      conn.close();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
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
          child: Text('Lista de pacentes...'),
        ),
        Container(
          child: Column(
            children: <Widget>[
              MaterialButton(
                minWidth: 100.0,
                height: 40.0,
                onPressed: () => _abrirRegistroPaciente(
                    context: context, fullscreenDialog: true),
                color: Colors.lightBlue,
                child: Text('NuevoPaciente',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
        Text('Lista de pacientes'),
        Container(
            height: 50,
            child: _model.length > 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _model.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Container(
                          height: 50,
                          child: ListTile(
                            leading: const Icon(Icons.list),
                            trailing: Text(
                              '${_model[index].nombre}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 15),
                            ),
                            title: Text('${_model[index].aprellidoP}'),
                            subtitle: Text('${_model[index].apellidoM}'),
                            onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('AlertDialog Title'),
                                content: const Text('AlertDialog description'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                          ));
                      /*  ListTile(
                  leading: const Icon(Icons.list),
                  trailing: Text(
                    '${_model[index].nombre}',
                    style: const TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text('${_model[index].aprellidoP}'),
                  subtitle: Text('${_model[index].apellidoM}'),
                  onTap: () {},
                );*/
                    }))
                : Text('Sin datos')),
      ],
    ));
  }

  void _abrirRegistroPaciente(
      {required BuildContext context, required bool fullscreenDialog}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => AgregarPaciente(),
      ),
    );
  }
}
