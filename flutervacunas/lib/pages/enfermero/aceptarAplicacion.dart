import 'package:flutervacunas/models/usuario.dart';
import 'package:flutervacunas/models/vacuna.dart';
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
  List<vacuna> _model = [];
  String? get idEnfer => idEnfer;
  String idC = '3';
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
          'select * from vacuna where idvacuna=(select idvacuna from campania where idcampania=(select idcampania from aplicacion where estado="pendiente" and idpaciente=?))',
          [widget.idEnfer]);
      results.forEach((row) {
        setState(() {
          vacuna v = vacuna();
          v.idvacuna = row.elementAt(0);
          v.nombreVacuna = row.elementAt(1).toString();
          v.num_dosis = row.elementAt(2).toString();
          v.descripcion = row.elementAt(3).toString();
          v.tipo = row.elementAt(4).toString();
          _model.add(v);
        });
      });
      // Finally, close the connection
      conn.close();
    });
    /* db.getConnection().then((conn) async {
      _model.clear();
      var results = await conn.query(
          'select idcampania from campania where idcampania=(select idcampania from aplicacion where idpaciente=?)',
          [widget.idEnfer]);

      for (var row in results) {
        idC = row[0];
      }
      // Finally, close the connection
      conn.close();
    });*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitudes de aplicación'),
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
                        title: Text('${_model[index].nombreVacuna}'),
                      ),
                      content: Text('${_model[index].descripcion}'),
                      buttonBar: GFButtonBar(children: <Widget>[
                        GFButton(
                          onPressed: () {
                            _mostrarAlerte(context, db);
                          },
                          text: 'Aplicar',
                        ),
                      ])),
                ));
          })),
    );
  }

  void _aprobarAplicacion(String idC, String? idEnfer, Mysql db) {
    print("ic campaña ${idC}");
    print("id paciente ${widget.idEnfer}");
    //INSERT INTO `pbdvacuna`.`aplicacion` (`estado`, `fecha`, `idcampania`, `idpaciente`) VALUES ('aplicada', '29/11/2022', '2', '1');
    db.getConnection().then((conn) async {
      var results = await conn.query(
          'insert into aplicacion (estado,fecha,idcampania,idpaciente) values(?,?,?,?)',
          ['aplicada', now, idC, widget.idEnfer]);
      conn.close();
    });
  }

//dialogo de alerta
  void _mostrarAlerte(BuildContext context, Mysql db) {
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
                _aprobarAplicacion(idC, idEnfer, db);
                Navigator.of(context).pop();
                _showCustomFlash();
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
