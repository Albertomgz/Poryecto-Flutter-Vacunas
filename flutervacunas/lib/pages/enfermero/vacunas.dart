import 'dart:convert';

import 'package:flutervacunas/pages/enfermero/editarVacuna.dart';

import 'agregarVacuna.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/models/vacuna.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flutervacunas/widgets/constant.dart';

class ListVacunas extends StatefulWidget {
  const ListVacunas({super.key});
  @override
  State<ListVacunas> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListVacunas> {
  var db = Mysql();
  List<vacuna> _model = [];
  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      _model.clear();
      var results = await conn.query('SELECT * FROM vacuna');
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Vacunas'),
      ),
      drawer: const LeftDrawerE(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), //child widget inside this button
          onPressed: () {
            //task to execute when this button is pressed
            _abrirRegistroVacuna(context: context, fullscreenDialog: true);
          },
          backgroundColor: Colors.lightBlue,
          tooltip: "Presione para nuevo registro "),
      //body: const MyStatelessWidget());
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
            'Vacunas',
            style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w800,
                fontSize: 30),
          ),
        ),
        Container(
            height: 400,
            child: _model.length > 0
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _model.length,
                    itemBuilder: ((BuildContext context, int index) {
                      return Container(
                          height: 50,
                          child: ListTile(
                            leading: const ImageIcon(
                              AssetImage('assets/images/vacunas.png'),
                              size: 30,
                              color: Colors.blue,
                            ),
                            trailing: Text(
                              '${_model[index].tipo}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 76, 175, 162),
                                  fontSize: 15),
                            ),
                            title: Text('${_model[index].nombreVacuna}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 4, 44, 65),
                                  fontSize: 12,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w800,
                                )),
                            subtitle: Text('Dosis: ${_model[index].num_dosis}'),
                            onTap: () {
                              _abrirEdicionVacuna(context, true, index, _model);
                            },
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

  void _abrirRegistroVacuna(
      {required BuildContext context, required bool fullscreenDialog}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => AgregarVacuna(),
      ),
    );
  }

  void _abrirEdicionVacuna(BuildContext context, bool fullscreenDialog,
      int index, List<vacuna> model) {
    String idVacu = model[index].idvacuna.toString();
    print("Se abre ediciond e ");
    print(idVacu);
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => EditarVacuna(idVacu: idVacu),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.user,
    required this.viewCount,
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              title: title,
              user: user,
              viewCount: viewCount,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }

  _abrirRegistroVacuna(
      {required BuildContext context, required bool fullscreenDialog}) {}
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    required this.title,
    required this.user,
    required this.viewCount,
  });

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount dosis',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 106.0,
      children: <CustomListItem>[
        CustomListItem(
          user: 'Recien nacido',
          viewCount: 1,
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          title: 'Hepatitis B',
        ),
        CustomListItem(
          user: 'Recien nacido',
          viewCount: 3,
          thumbnail: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 163, 59),
            ),
          ),
          title: 'Tuberculosis meningea',
        ),
        CustomListItem(
          user: '4 años',
          viewCount: 1,
          thumbnail: Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          title: 'DPT',
        ),
        CustomListItem(
          user: '2,3,6 meses',
          viewCount: 3,
          thumbnail: Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          title: 'Rotavirus',
        ),
      ],
    );
  }
}
