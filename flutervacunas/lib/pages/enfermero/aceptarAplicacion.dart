import 'package:flutervacunas/models/aplicacion.dart';
import 'package:flutervacunas/models/usuario.dart';
import 'package:flutervacunas/pages/enfermero/pacientes.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flash/flash.dart';
import 'package:flutervacunas/widgets/constant.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class AceptarAplicacion extends StatefulWidget {
  final String idEnfer;
  const AceptarAplicacion({super.key, required this.idEnfer});

  @override
  State<AceptarAplicacion> createState() => _MedicopageState();
}

// ignore: camel_case_types
class _MedicopageState extends State<AceptarAplicacion> {
  var db = Mysql();
  List<aplicacion> _model = [];
  String? get idEnfer => idEnfer;
  String idC = '2';
  DateTime fechaactual =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime now = new DateTime.now();
  DateFormat formato = new DateFormat('yyyy-MM-dd');
  //String formatoFecha = formato.format(now);

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      _model.clear();
      var results = await conn.query(
          'select vacuna.idvacuna,campania.idcampania,vacuna.nombre,campania.titulo,vacuna.descripcion,aplicacion.idaplicacion from vacuna inner join campania  on campania.idvacuna=vacuna.idvacuna inner join aplicacion on campania.idcampania=aplicacion.idcampania and aplicacion.estado="pendiente" and aplicacion.idpaciente=?',
          [widget.idEnfer]);
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
                            content:
                                Text('${_model[index].descripcionVacunaA}'),
                            buttonBar: GFButtonBar(children: <Widget>[
                              GFButton(
                                onPressed: () {
                                  _mostrarAlerte(context, db,
                                      _model[index].idAplicacion.toString());
                                },
                                text: 'Aplicar',
                              ),
                            ])),
                      ));
                }))
            : Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.topCenter,
                child: const Text(
                  'Sin solicitudes...',
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

  void _aprobarAplicacion(Mysql db, String idA) {
    print("ic aplicacion ${idA}");
    //UPDATE `pbdvacuna`.`aplicacion` SET `estado` = 'aplicada' WHERE (`idaplicacion` = '1');

    db.getConnection().then((conn) async {
      var results = await conn.query(
          'update aplicacion set estado="aplicada" where idaplicacion=?',
          [idA]).then((value) => _showCustomFlash());
      conn.close();
    });
  }

//dialogo de alerta
  void _mostrarAlerte(BuildContext context, Mysql db, String idA) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Aprobar aplicación'),
        content: Text(
            '¿Esta seguro de realizar la actualización de la aplicación de la vacuna?'),
        actions: [
          MaterialButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('No')),
          MaterialButton(
              onPressed: () {
                _aprobarAplicacion(db, idA);
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListPacientes(),
                  ),
                );
              },
              child: Text('Si'))
        ],
      ),
    );
  }

  void _showCustomFlash() {
    showFlash(
      context: context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          backgroundGradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 10, 73, 145)],
          ),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('Exito'),
              content:
                  Text('¡Se a actualizado la información del la aplicación.!'),
              indicatorColor: Colors.blue,
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child:
                    const Text('Cerrar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        );
      },
    );
  }
}
