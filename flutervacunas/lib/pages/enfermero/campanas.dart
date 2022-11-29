import 'agregarCampana.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/models/campaniamodel.dart';
import 'package:flutervacunas/database/mysql.dart';

class CampanasVacunasE extends StatefulWidget {
  const CampanasVacunasE({super.key});

  @override
  State<CampanasVacunasE> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CampanasVacunasE> {
  var db = Mysql();
  List<Campania> _model = [];
  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      _model.clear();
      var results = await conn.query('SELECT * FROM campania');
      //  print('Resultado::');
      // print('${results}');

      results.forEach((row) {
        setState(() {
          Campania c = Campania();
          c.tituloCampania = row.elementAt(1).toString();
          c.fechainicio = row.elementAt(2).toString();
          c.fechafinal = row.elementAt(3).toString();
          c.descripcionCampania = row.elementAt(4).toString();
          _model.add(c);
          // print('Valores---->');
          //  print(row.values!.elementAt(0).toString());
          // print('Tamaño map---->');
          // print(_model.length);
        });
      });
      // Finally, close the connection
      conn.close();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Campañas de vacunación'),
      ),
      drawer: const LeftDrawerE(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), //child widget inside this button
          onPressed: () {
            //task to execute when this button is pressed
            _abrirRegistroCampana(context: context, fullscreenDialog: true);
          },
          backgroundColor: Colors.lightBlue,
          tooltip: "Presione para nuevo registro "),
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
          child: Text('Lista de campañas...'),
        ),
        Container(
            height: 450,
            child: _model.length > 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _model.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return /*Container(
                          height: 50,
                          child: ListTile(
                            leading: const Icon(Icons.list),
                            trailing: Text(
                              '${_model[index].titulo}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 15),
                            ),
                            title: Text('${_model[index].fechaFin}'),
                            subtitle: Text('${_model[index].fechaInicio}'),
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
                          )*/
                          ListTile(
                        leading: const Icon(Icons.list),
                        trailing: Text(
                          '${_model[index].tituloCampania}',
                          style: const TextStyle(
                              color: Colors.green, fontSize: 15),
                        ),
                        title: Text('${_model[index].fechainicio}'),
                        subtitle: Text('${_model[index].fechafinal}'),
                        onTap: () {},
                      );
                      // );
                    }))
                : Text('Sin datos')),
      ],
    ));
  }

  void _abrirRegistroCampana(
      {required BuildContext context, required bool fullscreenDialog}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => AgregarCampana(),
      ),
    );
  }
}
