// To parse this JSON data, do
//
//     final datosPersonales = datosPersonalesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DatosPersonales {
  DatosPersonales({
    this.estatus,
    this.datos,
  });

  String? estatus;
  Datos? datos;

  factory DatosPersonales.fromJson(String str) =>
      DatosPersonales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosPersonales.fromMap(Map<String, dynamic> json) => DatosPersonales(
        estatus: json["estatus"],
        datos: Datos.fromMap(json["datos"]),
      );

  Map<String, dynamic> toMap() => {
        "estatus": estatus,
        "datos": datos!.toMap(),
      };
}

class Datos {
  Datos({
    required this.estatus,
    required this.curp,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.nombre,
    required this.sexo,
    required this.fechaNacimiento,
    required this.nacionalidad,
    required this.docProbatorio,
    required this.anioReg,
    required this.foja,
    required this.tomo,
    required this.libro,
    required this.numActa,
    required this.crip,
    required this.numEntidadReg,
    required this.cveMunicipioReg,
    required this.numRegExtranjeros,
    required this.folioCarta,
    required this.cveEntidadEmisora,
    required this.statusCurp,
  });

  String estatus;
  String curp;
  String apellidoPaterno;
  String apellidoMaterno;
  String nombre;
  String sexo;
  DateTime fechaNacimiento;
  String nacionalidad;
  String docProbatorio;
  String anioReg;
  String foja;
  String tomo;
  String libro;
  String numActa;
  String crip;
  String numEntidadReg;
  String cveMunicipioReg;
  String numRegExtranjeros;
  String folioCarta;
  String cveEntidadEmisora;
  String statusCurp;

  factory Datos.fromJson(String str) => Datos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datos.fromMap(Map<String, dynamic> json) => Datos(
        estatus: json["estatus"],
        curp: json["Curp"],
        apellidoPaterno: json["ApellidoPaterno"],
        apellidoMaterno: json["ApellidoMaterno"],
        nombre: json["Nombre"],
        sexo: json["Sexo"],
        fechaNacimiento: DateTime.parse(json["FechaNacimiento"]),
        nacionalidad: json["Nacionalidad"],
        docProbatorio: json["DocProbatorio"],
        anioReg: json["AnioReg"],
        foja: json["Foja"],
        tomo: json["Tomo"],
        libro: json["Libro"],
        numActa: json["NumActa"],
        crip: json["CRIP"],
        numEntidadReg: json["NumEntidadReg"],
        cveMunicipioReg: json["CveMunicipioReg"],
        numRegExtranjeros: json["NumRegExtranjeros"],
        folioCarta: json["FolioCarta"],
        cveEntidadEmisora: json["CveEntidadEmisora"],
        statusCurp: json["StatusCurp"],
      );

  Map<String, dynamic> toMap() => {
        "estatus": estatus,
        "Curp": curp,
        "ApellidoPaterno": apellidoPaterno,
        "ApellidoMaterno": apellidoMaterno,
        "Nombre": nombre,
        "Sexo": sexo,
        "FechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "Nacionalidad": nacionalidad,
        "DocProbatorio": docProbatorio,
        "AnioReg": anioReg,
        "Foja": foja,
        "Tomo": tomo,
        "Libro": libro,
        "NumActa": numActa,
        "CRIP": crip,
        "NumEntidadReg": numEntidadReg,
        "CveMunicipioReg": cveMunicipioReg,
        "NumRegExtranjeros": numRegExtranjeros,
        "FolioCarta": folioCarta,
        "CveEntidadEmisora": cveEntidadEmisora,
        "StatusCurp": statusCurp,
      };
}
