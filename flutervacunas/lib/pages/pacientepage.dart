import 'package:flutervacunas/models/campaniamodel.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../database/mysql.dart';

// ignore: must_be_immutable
class ListCampania extends StatefulWidget {
  String idusuario;
  ListCampania({super.key, required this.idusuario});
  @override
  State<ListCampania> createState() => _MyWidgetState();

  String? get idUsuario => idusuario;
}

class _MyWidgetState extends State<ListCampania> {
  var db = Mysql();
  List<Campania> _model = [];

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      /*var resultsedad = await conn
          .query('SELECT edad FROM usuario where edad = ?', [aux.idUsuario]);

      print(resultsedad);*/

      _model.clear();
      var results = await conn.query('SELECT * FROM campania');

      results.forEach((row) {
        setState(() {
          Campania c = Campania();
          c.tituloCampania = row.elementAt(1).toString();
          c.fechainicio = row.elementAt(2).toString();
          c.fechafinal = row.elementAt(3).toString();
          c.descripcionCampania = row.elementAt(4).toString();
          c.ubicacion = row.elementAt(5).toString();
          c.img = row.elementAt(6).toString();
          c.idVacuna == row.elementAt(4).toString();
          _model.add(c);
        });
      });

      var resultsvacuna = await conn.query('SELECT * FROM campania');

      conn.close();
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Campañas de vacunación'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _model.length,
            itemBuilder: ((BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('assets/images/17538.jpg',
                            color: Colors.blue),
                        title: GFListTile(
                          title: Text('${_model[index].tituloCampania}'),
                        ),
                        content: Text('${_model[index].descripcionCampania}'),
                        buttonBar: GFButtonBar(children: <Widget>[
                          GFButton(
                            onPressed: () {},
                            text: 'Ver mas',
                          ),
                        ])),
                  )
                  );
            }
            )
            )
            );
  }
}
