import 'package:flutter/material.dart';
import 'menu_list_tilePaciente.dart';

// ignore: must_be_immutable
class LeftDrawerEPa extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var nombreU;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var CURP;
  // ignore: non_constant_identifier_names
  LeftDrawerEPa({super.key, required this.nombreU, required this.CURP});

  @override
  // ignore: no_logic_in_create_state
  State<LeftDrawerEPa> createState() => _MyWidgetState(nombreU, CURP);
}

class _MyWidgetState extends State<LeftDrawerEPa> {
  String? nomCom;
  String? curpUser;
  // ignore: non_constant_identifier_names
  _MyWidgetState(var nombreU, var CURP) {
    nomCom = nombreU;
    curpUser = CURP;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("LUIS ALBERTO MARTINEZ",
                textAlign: TextAlign.center,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black)),
            accountEmail: Text("MAGL990701HPLRNS01",
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black)),
            // ignore: prefer_const_constructors
            currentAccountPicture: CircleAvatar(
              backgroundImage: const AssetImage("assets/images/4.png"),
              radius: 100,
            ),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                color: Colors.amber,
                gradient: const LinearGradient(
                  colors: [Colors.white, Color.fromRGBO(1, 87, 155, 1)],
                )),
          ),
          MenuListTileWidgetPa(
            nombreU: nomCom,
            curpUser: curpUser,
          ),
        ],
      ),
    );
  }
}
