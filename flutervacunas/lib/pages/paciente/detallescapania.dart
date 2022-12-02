import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/mysql.dart';
import '../../widgets/constant.dart';
import '../../widgets/paciente/left_drawerPaciente.dart';

class DetallesCapania extends StatefulWidget {
  var idCampania;
  DetallesCapania({super.key, required this.idCampania});

  @override
  State<DetallesCapania> createState() => _DetallesCapaniaState();
}

class _DetallesCapaniaState extends State<DetallesCapania> {
  var db = Mysql();

  var NomCa = '';
  var fechaInicio = '';
  var fechaFin = '';
  var descripcion = '';
  var rango = '';
  var ubicacion = '';
  int idVa = 0;
  var NomVa = '';
  int Dosis = 0;
  var descripcionVa = '';
  var tipo = '';

  String des = "";

  final s = StringBuffer();

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      var resultsCampania = await conn.query(
          'select vacuna.idvacuna,vacuna.nombre,vacuna.descripcion,vacuna.num_dosis,vacuna.tipo,campania.titulo,campania.fechaInicio,campania.fechaFin,campania.descripcion,campania.rango,campania.ubicacion from vacuna inner join campania  on campania.idvacuna=vacuna.idvacuna and campania.idcampania=?',
          [widget.idCampania]);

      for (var row in resultsCampania) {
        setState(() {
          idVa = row[0];
          NomVa = row[1];
          descripcionVa = row[2];
          Dosis = row[3];
          tipo = row[4];
          NomCa = row[5];
          fechaInicio = row[6];
          fechaFin = row[7];
          descripcion = row[8];
          rango = row[9];
          ubicacion = row[10];
        });
      }

      conn.close();
    });

    s.clear();
    s.toString();
    s.write(descripcion);
    s.write(" ");
    s.write(descripcionVa);

    des = s.toString();

    final fechaini = Container(
      child: Container(
        // ignore: prefer_const_constructors
        child: LinearProgressIndicator(
            backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
            value: 20,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final fechafin = Container(
      child: Container(
        // ignore: prefer_const_constructors
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 20,
            valueColor: AlwaysStoppedAnimation(Colors.red)),
      ),
    );

    final DosisVa = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        Dosis.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );

    final Nombreva = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        NomVa,
        style: TextStyle(color: Colors.white),
      ),
    );
    final Tipova = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        tipo,
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ignore: prefer_const_constructors
        SizedBox(height: 120.0),
        // ignore: prefer_const_constructors
        Icon(
          Icons.vaccines,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: const Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          NomCa,
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(child: Nombreva),
            SizedBox(height: 10.0),
            Flexible(child: DosisVa),
            Flexible(child: Tipova),
          ],
        ),

        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: fechaini),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      fechaInicio,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: fechafin),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      fechaFin,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/IMSSLogo.png"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.9)),
          child: Center(
            child: topContentText,
          ),
        ),
      ],
    );

    final bottomContentText = Text(
      des,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () => SolicitarVacuna(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
          child: Text("Solicitar aplicación",
              style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campañas de vacunación'),
      ),
      drawer: LeftDrawerEPa(
        nombreU: "nUser",
        CURP: "widusuarioidget",
      ),
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  SolicitarVacuna(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    db.getConnection().then((conn) async {
      var resultsAplica = await conn.query(
          'insert into aplicacion (estado,fecha,idcampania,idpaciente ) values (?,?,?,?)',
          ['pendiente', formatted, widget.idCampania, idVa]);

      print("New user's id: ${resultsAplica.insertId}");

      conn.close();
    });
  }
}
