import 'package:flutervacunas/pages/enfermero/editarCampania.dart';

import 'agregarCampana.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/models/campaniamodel.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutervacunas/widgets/constant.dart';
import 'package:flash/flash.dart';

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
          c.idcampania = row.elementAt(0);
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
        title: Text('Lista de campañas'),
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
          child: const Text(
            'Campañas',
            style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w800,
                fontSize: 30),
          ),
        ),
        Container(
            height: 450,
            child: _model.length > 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _model.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: GFCard(
                                boxFit: BoxFit.cover,
                                image: Image.asset('assets/images/17538.jpg',
                                    color: Colors.blue),
                                title: GFListTile(
                                  title: Text(
                                    'Título: ${_model[index].tituloCampania}',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 4, 44, 65),
                                      fontSize: 14,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  subTitle: Text(
                                      '${_model[index].fechainicio} al ${_model[index].fechafinal}'),
                                ),
                                content: Text(
                                    '${_model[index].descripcionCampania}'),
                                buttonBar: GFButtonBar(children: <Widget>[
                                  GFButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      _mostrarAlerte2(
                                          context, db, index, _model);
                                    },
                                    text: 'Eliminar',
                                    textColor: Colors.black,
                                    icon: Icon(Icons.delete_outline,
                                        color: Colors.black),
                                  ),
                                  GFButton(
                                    color: Colors.yellow,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      _abrirEdicionCampana(
                                          context, true, index, _model);
                                    },
                                    text: 'Editar',
                                    icon: Icon(
                                      Icons.drive_file_rename_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ])),
                          ));
                    }))
                : Text('Sin datos')),
      ],
    ));
  }

  //dialogo de alerta
  void _mostrarAlerte(
      BuildContext context, int? idcampania, Mysql db, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar registro'),
        content: Text('¿Esta seguro de elimaar esta campaña?'),
        actions: [
          MaterialButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('No')),
          MaterialButton(
              onPressed: () {
                _elimimarCampania(_model[index].idcampania, db);
                Navigator.of(context).pop();
              },
              child: Text('Si'))
        ],
      ),
    );
  }

  void _mostrarAlerte2(
      BuildContext context, Mysql db, int index, List<Campania> model) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar registro'),
        content: Text('¿Esta seguro de eliminar esta campaña?'),
        actions: [
          MaterialButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('No')),
          MaterialButton(
              onPressed: () {
                _elimimarCampania(model[index].idcampania, db);
                Navigator.of(context).pop();
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
              content: Text('¡Campaña eliminada con exito!'),
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

  void _elimimarCampania(int? idcampania, Mysql db) {
    print('Id de la campañia a eliminar');
    print(idcampania.toString());
    String idC = idcampania.toString();

    //DELETE FROM `pbdvacuna`.`campania` WHERE (`idcampania` = '16');
    db.getConnection().then((conn) async {
      var results = await conn.query(
          'DELETE FROM campania WHERE idcampania = ?',
          [idC]).then((value) => _showCustomFlash());
      conn.close();
    });
  }
}

_abrirEdicionCampana(BuildContext context, bool fullscreenDialog, int index,
    List<Campania> model) {
  String idCamp = model[index].idcampania.toString();
  print("Se abre ediciond e ");
  print(idCamp);
  Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: fullscreenDialog,
      builder: (context) => EditarCampana(idCamp: idCamp),
    ),
  );
}
