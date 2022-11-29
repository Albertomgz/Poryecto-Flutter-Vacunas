import 'dart:convert';

import 'agregarVacuna.dart';
import 'package:flutervacunas/widgets/enfermero/left_drawerEnfermero.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/models/vacuna.dart';
import 'package:flutervacunas/database/mysql.dart';

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
      //  print('Resultado::');
      // print('${results}');

      results.forEach((row) {
        setState(() {
          vacuna v = vacuna();
          v.nombreVacuna = row.elementAt(1).toString();
          v.num_dosis = row.elementAt(2).toString();
          v.descripcion = row.elementAt(3).toString();
          v.tipo = row.elementAt(4).toString();
          _model.add(v);
          /*    print('Valores---->');
          print(row.values!.elementAt(0).toString());
          print('Tamaño map---->');
          print(_model.length);*/
        });
      });
      /*for (var row in results) {
        tipo = row[0];
      }*/
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
          child: Text('Lista de vacunas...'),
        ),
        Text('Lista de vacunas'),
        Container(
            height: 500,
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
                              '${_model[index].nombreVacuna}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 15),
                            ),
                            title: Text('${_model[index].num_dosis}'),
                            subtitle: Text('${_model[index].descripcion}'),
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
