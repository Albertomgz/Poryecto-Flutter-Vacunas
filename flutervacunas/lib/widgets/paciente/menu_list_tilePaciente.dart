// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../pages/login.dart';
import '../../pages/paciente/googlemaps.dart';
import '../../pages/paciente/historialPa.dart';
import '../../pages/paciente/miPerfilPa.dart';
import '../../pages/paciente/pacientepage.dart';

// ignore: must_be_immutable
class MenuListTileWidgetPa extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var nombreU;
  var curpUser;
  MenuListTileWidgetPa(
      {super.key, required this.nombreU, required this.curpUser});

  @override
  // ignore: no_logic_in_create_state, library_private_types_in_public_api
  _menuPaciente createState() => _menuPaciente(nombreU, curpUser);
}

// ignore: camel_case_types
class _menuPaciente extends State<MenuListTileWidgetPa> {
  // ignore: prefer_typing_uninitialized_variables
  var nomUserC;
  // ignore: prefer_typing_uninitialized_variables
  var curpUserC;

  _menuPaciente(var nombreU, var curpUser) {
    nomUserC = nombreU;
    curpUserC = curpUser;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ListTile(
          title: Text(
            'PACIENTE',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/images/expediente.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: const Text('Mi historial'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistorialPa(
                  idusuario: nomUserC,
                  curpUser: curpUserC,
                ),
              ),
            );
          },
        ),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/images/oficina.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: const Text('Centros de salud'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
          },
        ),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/images/campana3.png'),
            size: 30,
            color: Colors.blue,
          ),
          title: const Text('Campañas de vacunación'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListCampania(
                  idusuario: nomUserC,
                ),
              ),
            );
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(
            Icons.badge_outlined,
            color: Colors.blue,
          ),
          title: const Text('Mi perfil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PerfilPa(
                  idusuario: nomUserC,
                  curpUser: curpUserC,
                ),
              ),
            );
          },
        ),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          title: const Text('Cerrar sesión'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
