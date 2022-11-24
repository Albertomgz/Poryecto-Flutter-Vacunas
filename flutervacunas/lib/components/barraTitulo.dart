// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../widgets/constant.dart';

// ignore: camel_case_types
class barraTitulo extends StatelessWidget {
  const barraTitulo({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 260.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: const BoxDecoration(
          color: kLightPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'roboto',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                // ignore: use_full_hex_values_for_flutter_colors
                color: Color(0xfff575861)),
          ),
        ),
      ),
    );
  }
}
