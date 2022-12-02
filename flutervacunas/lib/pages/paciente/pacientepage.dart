import 'package:flutervacunas/models/campaniamodel.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../database/mysql.dart';
import '../../widgets/paciente/left_drawerPaciente.dart';
import 'detallescapania.dart';

// ignore: must_be_immutable
class ListCampania extends StatefulWidget {
  String idusuario;
  ListCampania({super.key, required this.idusuario});
  @override
  // ignore: no_logic_in_create_state
  State<ListCampania> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListCampania> {
  var db = Mysql();
  String? nombre = "";
  String? appno = "";
  String? apmno = "";
  int? edaduser;
  String? nUser = "";
  final s = StringBuffer();
  // ignore: prefer_final_fields
  List<Campania> _model = [];

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      var resultsUser = await conn.query(
          'SELECT nombre,app,apm,edad FROM usuario where curp = ?',
          [widget.idusuario]);

      for (var row in resultsUser) {
        nombre = row[0];
        appno = row[1];
        apmno = row[2];
        edaduser = row[3];
      }

      _model.clear();
      var results = await conn.query('SELECT * FROM campania ');

      for (var row in results) {
        setState(() {
          Campania c = Campania();
          c.idcampania = row.elementAt(0);
          c.tituloCampania = row.elementAt(1).toString();
          c.fechainicio = row.elementAt(2).toString();
          c.fechafinal = row.elementAt(3).toString();
          c.descripcionCampania = row.elementAt(4).toString();
          c.ubicacion = row.elementAt(5).toString();
          c.img = row.elementAt(6).toString();
          c.idVacuna = row.elementAt(7).toString();
          _model.add(c);
        });
      }

      conn.close();
    });

    s.clear();
    s.toString();
    s.write(nombre);
    s.write(" ");
    s.write(appno);
    s.write(" ");
    s.write(apmno);

    nUser = s.toString();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Campañas de vacunación'),
        ),
        drawer: LeftDrawerEPa(
          nombreU: widget.idusuario,
          CURP: widget.idusuario,
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
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      boxFit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/images.png',
                        width: double.infinity,
                      ),
                      showImage: true,
                      title: GFListTile(
                          title: Text(
                        '${_model[index].tituloCampania}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                      content: Text(
                        '${_model[index].descripcionCampania}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      buttonBar: GFButtonBar(
                        alignment: WrapAlignment.start,
                        children: <Widget>[
                          GFButton(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.blue.withOpacity(0.9),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetallesCapania(
                                    idCampania: '${_model[index].idcampania}',
                                  ),
                                ),
                              );
                            },
                            text: 'Ver mas...',
                          ),
                        ],
                      ),
                    ),
                  ));
            })));
  }
}
