import 'package:flutter/material.dart';
import 'package:flutervacunas/pages/enfermero/miPerfil.dart';
import 'package:flutervacunas/pages/enfermero/campanas.dart';
import 'package:flutervacunas/pages/enfermero/pacientes.dart';
import 'package:flutervacunas/pages/enfermero/vacunas.dart';

import '../../pages/login.dart';

class MenuListTileWidget extends StatefulWidget {
  const MenuListTileWidget({super.key});

  @override
  _menuPaciente createState() => _menuPaciente();
}

class _menuPaciente extends State<MenuListTileWidget> {
  int _selectDrawerItem = 0;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'ENFERMER@',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: ImageIcon(
            AssetImage('assets/images/pacientes.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: Text('Pacientes'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListPacientes(),
              ),
            );
          },
        ),
        ListTile(
          leading: ImageIcon(
            AssetImage('assets/images/vacunas.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: Text('Vacunas'),
          onTap: () {
           Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListVacunas(),
              ),
            );
          },
        ),
        ListTile(
          leading: ImageIcon(
            AssetImage('assets/images/campana3.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: Text('Campañas de vacunación'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CampanasVacunasE(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(
            Icons.badge_outlined,
            color: Colors.blue,
          ),
          title: Text('Mi perfil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => miPefilE(),
              ),
            );
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(
            Icons.close,
            color: Colors.red,
          ),
          title: Text('Cerrar sesión'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
