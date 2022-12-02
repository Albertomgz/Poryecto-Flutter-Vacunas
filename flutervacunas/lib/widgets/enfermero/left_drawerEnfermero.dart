import 'package:flutter/material.dart';
import 'menu_list_tileEnfermero.dart';

class LeftDrawerE extends StatefulWidget {
  const LeftDrawerE({super.key});

  @override
  State<LeftDrawerE> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LeftDrawerE> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          UserAccountsDrawerHeader(
            /*currentAccountPicture: Icon(
              Icons.face,
              size: 48.0,
              color: Colors.white,
            ),*/
            accountName: Text('Nombre: AYLIN CIELO RODRIGUEZ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black)),
            accountEmail: Text('CURP: CIRA000224MPLLDYA6',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/4.png"),
              radius: 100,
            ),
            decoration: BoxDecoration(
                color: Colors.amber,
                gradient: LinearGradient(
                  colors: [Colors.white, Color.fromRGBO(1, 87, 155, 1)],
                )),
          ),
          MenuListTileWidget(),
        ],
      ),
    );
  }
}
