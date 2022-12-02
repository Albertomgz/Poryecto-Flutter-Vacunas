import 'package:flutervacunas/database/mysql.dart';
import 'package:flutervacunas/models/campaniamodel.dart';
import 'package:flutervacunas/pages/enfermero/campanas.dart';
import 'package:flutervacunas/pages/pacientepage.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:flutervacunas/widgets/constant.dart';

class EditarCampana extends StatefulWidget {
  final String idCamp;
  const EditarCampana({super.key, required this.idCamp});

  @override
  State<EditarCampana> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditarCampana> {
  //Variable de la clase globalKey para manejar formulario
  GlobalKey<FormState> keyFormB = new GlobalKey();
  GlobalKey<FormState> keyForm = new GlobalKey();
  var db = Mysql();
  var estado = false;
  String _errorMessageVacuna = "";
  //Controladores para guardar los valores escritos para las cajas de tetxo
  TextEditingController nombVacunaBuscarCtr = new TextEditingController();

  TextEditingController idVacunaCtrl = new TextEditingController();
  TextEditingController tituloCCtrl = new TextEditingController();
  TextEditingController fechaInicioCtrl = new TextEditingController();
  TextEditingController fechaFinCtrl = new TextEditingController();
  TextEditingController descripcionCtrl = new TextEditingController();
  TextEditingController ubicacionCtrl = new TextEditingController();
  TextEditingController rangoCtrl = new TextEditingController();
  TextEditingController imgCtrl = new TextEditingController();

// Variables de texto
  var tituloV = '';
  var fichaI = '';
  var fechaF = '';
  var descripcion = '';
  var idV = 0;
  var ubicacionV = '';
  var rangoV = '';
  String nomVacuna = '';
  String nombreV = '';
  //Otras variables
  final _formKeyB = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  // ignore: recursive_getters
  String? get idCamp => idCamp;

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      var results = await conn
          .query('SELECT * FROM campania where idcampania=?', [widget.idCamp]);
      //  print('Resultado::');
      // print('${results}');

      results.forEach((row) {
        tituloCCtrl.text = row[1];
        fechaInicioCtrl.text = row[2];
        fechaFinCtrl.text = row[3];
        descripcionCtrl.text = row[4];
        ubicacionCtrl.text = row[5];
        rangoCtrl.text = row[6];
        imgCtrl.text = row[7];
        idVacunaCtrl.text = row[8].toString();
      });
      // Finally, close the connection
      conn.close();
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar campaña'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: keyForm,
            child: formUI(size),
          ),
        )));
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI(Size size) {
    String nombreV = "";
    return Column(
      children: <Widget>[
        Text(widget.idCamp),
        //Busqueda
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: kLightPrimaryColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextFormField(
            controller: nombVacunaBuscarCtr,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                hintText: 'Buscar vacuna por nombre',
                hintStyle: TextStyle(fontFamily: 'roboto'),
                border: InputBorder.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            _errorMessageVacuna,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton.icon(
              icon: Icon(Icons.search),
              onPressed: () => getVacuna(context),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                      letterSpacing: 2,
                      color: kLightPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans')),
              label: const Text("Buscar vacuna",
                  style: TextStyle(
                    color: kLightPrimaryColor,
                    fontSize: 17,
                  )),
            ),
          ),
        ),
        //Aqui van los elementos de nuestro dormulario
        formItemsDesign(
            Icons.pin,
            TextFormField(
              controller: idVacunaCtrl,
              decoration: const InputDecoration(
                labelText: 'idVacuna',
              ),
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text?.length == 0) {
                  return "Este dato es necesario";
                }
                return null;
              },
            )),
        formItemsDesign(
          Icons.format_size,
          TextFormField(
            controller: tituloCCtrl,
            decoration: const InputDecoration(
              labelText: 'Titulo campaña',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z0-9_.-]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "El titulo es necesario";
              } else if (!regExp.hasMatch(text!)) {
                return "El titulo puede tener letras, números, punto o guiones.";
              }
              return null;
            },
          ),
        ),

        formItemsDesign(
            Icons.today,
            TextFormField(
              controller: fechaInicioCtrl,
              decoration: const InputDecoration(
                labelText: 'Fecha inicio (dd/mm/aaaa)',
              ),
              keyboardType: TextInputType.datetime,
              validator: (text) {
                String pattern =
                    r'^(?:3[01]|[12][0-9]|0?[1-9])([\-/.])(0?[1-9]|1[1-2])\1\d{4}$';
                RegExp regExp = new RegExp(pattern);

                if (text?.length == 0) {
                  return "Este dato es necesario";
                } else if (!regExp.hasMatch(text!)) {
                  return "Formato invalido para fecha";
                }
                return null;
              },
            )),

        formItemsDesign(
            Icons.insert_invitation,
            TextFormField(
              controller: fechaFinCtrl,
              decoration: const InputDecoration(
                labelText: 'Fecha final (dd/mm/aaaa)',
              ),
              keyboardType: TextInputType.datetime,
              validator: (text) {
                String pattern =
                    r'^(?:3[01]|[12][0-9]|0?[1-9])([\-/.])(0?[1-9]|1[1-2])\1\d{4}$';
                RegExp regExp = new RegExp(pattern);

                if (text?.length == 0) {
                  return "Este dato es necesario";
                } else if (!regExp.hasMatch(text!)) {
                  return "Formato invalido para fecha";
                }
                return null;
              },
            )),
        formItemsDesign(
          Icons.location_on,
          TextFormField(
            onChanged: (value) {
              ubicacionV = value;
            },
            controller: ubicacionCtrl,
            decoration: const InputDecoration(
              labelText: 'Ubicación',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z ]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "Este dato es necesario";
              }
              return null;
            },
          ),
        ),
        formItemsDesign(
          Icons.stacked_bar_chart,
          TextFormField(
            onChanged: (value) {
              rangoV = value;
            },
            controller: rangoCtrl,
            decoration: const InputDecoration(
              labelText: 'Rango',
            ),
            validator: (text) {
              if (text?.length == 0) {
                return "Este dato es necesario";
              }
              return null;
            },
          ),
        ),
        formItemsDesign(
            Icons.description,
            TextFormField(
              controller: descripcionCtrl,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              keyboardType: TextInputType.text,
              maxLength: 200,
              validator: (text) {
                String pattern = r'(^[a-zA-Z ]*$)';
                RegExp regExp = new RegExp(pattern);

                if (text?.length == 0) {
                  return "La descripcion es necesario";
                } else if (!regExp.hasMatch(text!)) {
                  return "La descripcion debe de ser a-z y A-Z";
                }
                return null;
              },
            )),
        GestureDetector(
          onTap: () {
            if (keyForm.currentState!.validate()) {
              _mostrarAlerte(context);
            }

            /// save();
          },
          child: Container(
            margin: const EdgeInsets.all(30.0),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: const LinearGradient(colors: [
                Color(0xFF0EDED2),
                Color(0xFF03A0FE),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: "Editar",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            )
            /* Text(
              "Guardar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )*/
            ,
          ),
        )
      ],
    );
  }

  //dialogo de alerta
  void _mostrarAlerte(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.question_mark),
        title: const Text(
          'Editar registro',
          style: TextStyle(
              color: Color.fromARGB(255, 7, 32, 255),
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '¿Esta seguro de realizar la edición de este registro?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              )),
          OutlinedButton(
              onPressed: () {
                save();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampanasVacunasE(),
                  ),
                );
              },
              child: Text(
                'Si',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }

  _editarRegistroCampana(BuildContext context) {
    tituloV = tituloCCtrl.text;
    fichaI = fechaInicioCtrl.text;
    fechaF = fechaFinCtrl.text;
    descripcion = descripcionCtrl.text;
    ubicacionV = ubicacionCtrl.text;
    rangoV = rangoCtrl.text;

    String idVa = idVacunaCtrl.text;

/**
 * idVacunaCtrl 
 */
    db.getConnection().then((conn) async {
      var results = await conn.query(
          'update campania set titulo=?,fechaInicio=?,fechaFin=?,descripcion=?,ubicacion=?,idvacuna=?,rango=? where idcampania=?',
          [
            tituloV,
            fichaI,
            fechaF,
            descripcion,
            ubicacionV,
            idVa,
            rangoV,
            widget.idCamp
          ]).then((value) => _showCustomFlash());
      conn.close();
    });
  }

  save() {
    if (keyForm.currentState!.validate()) {
      _editarRegistroCampana(context);
      print("Nombre ${tituloCCtrl.text}");
      print("Edad ${fechaInicioCtrl.text}");
      print("Descripción ${fechaFinCtrl.text}");
      print("Número dosis ${descripcionCtrl.text}");
      print("Ubicacion ${ubicacionCtrl.text}");
      print("rango ${rangoCtrl.text}");
      keyForm.currentState!.reset();
    }
  }

  void _showCustomFlashEliminar() {
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
              content: Text('ELiminación exitoso!'),
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
              content: Text('¡Edición exitoso!'),
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

  void _buscarVacuna() {}

  getVacuna(BuildContext context) {
    setState(() {
      _errorMessageVacuna = "";
    });

    nomVacuna = nombVacunaBuscarCtr.text;
    var results;
    if (nomVacuna.isEmpty) {
      setState(() {
        _errorMessageVacuna = "Campo vacio, porfavor introduzca el dato";
      });
    } else {
      db.getConnection().then((conn) async {
        results = await conn
            .query('SELECT idvacuna FROM vacuna WHERE nombre = ?', [nomVacuna]);

        for (var row in results) {
          nombreV = row[0].toString();
        }

        conn.close();
      });
      print('nombre V');
      print(nombreV);
      setState(() {
        idVacunaCtrl.text = nombreV;
      });
    }
  }
}
