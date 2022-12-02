// ignore_for_file: unused_import
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

import '../../database/mysql.dart';
import '../../models/aplicacion.dart';
import '../../widgets/paciente/left_drawerPaciente.dart';

// ignore: must_be_immutable
class HistorialPa extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var idusuario;
  // ignore: prefer_typing_uninitialized_variables
  var curpUser;
  HistorialPa({super.key, required this.idusuario, required this.curpUser});

  @override
  // ignore: no_logic_in_create_state
  State<HistorialPa> createState() => _HistorialPaState(idusuario, curpUser);
}

class _HistorialPaState extends State<HistorialPa> {
  // ignore: prefer_typing_uninitialized_variables
  var nomC;
  // ignore: prefer_typing_uninitialized_variables
  var userC;
  _HistorialPaState(var idusuario, var curpUser) {
    nomC = idusuario;
    userC = curpUser;
  }

  @override
  Widget build(BuildContext context) {
    var db = Mysql();
    List<aplicacion> _model = [];

    db.getConnection().then((conn) async {
      _model.clear();
      var results = await conn.query(
        'select vacuna.idvacuna,campania.idcampania,vacuna.nombre,campania.titulo,vacuna.descripcion,aplicacion.idaplicacion from vacuna inner join campania  on campania.idvacuna=vacuna.idvacuna inner join aplicacion on campania.idcampania=aplicacion.idcampania and aplicacion.estado="aplicada" and aplicacion.idpaciente=?',
        [1],
      );
      results.forEach((row) {
        setState(() {
          aplicacion a = aplicacion();
          a.idVacuA = row.elementAt(0).toString();
          a.idCampaA = row.elementAt(1).toString();
          a.nombreVacunaA = row.elementAt(2);
          a.nombreCampanaA = row.elementAt(3);
          a.descripcionVacunaA = row.elementAt(4);
          a.idAplicacion = row.elementAt(5);
          _model.add(a);
        });
      });
      // Finally, close the connection
      conn.close();
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Solicitudes de aplicación'),
        ),
        body: _model.length > 0
            ? ListView.builder(
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
                            title: Text('${_model[index].nombreVacunaA}'),
                          ),
                          content: Text('${_model[index].descripcionVacunaA}'),
                        )),
                  );
                }))
            : Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.topCenter,
                child: const Text(
                  'Historial vacio',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ));
  }
}
