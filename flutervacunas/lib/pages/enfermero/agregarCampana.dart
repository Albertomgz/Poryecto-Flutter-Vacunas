import 'package:flutervacunas/database/mysql.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class AgregarCampana extends StatefulWidget {
  const AgregarCampana({super.key});

  @override
  State<AgregarCampana> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AgregarCampana> {
  //Variable de la clase globalKey para manejar formulario
  GlobalKey<FormState> keyFormB = new GlobalKey();
  GlobalKey<FormState> keyForm = new GlobalKey();
  var db = Mysql();
  var estado = false;
  //Controladores para guardar los valores escritos para las cajas de tetxo
  TextEditingController nombVacunaBuscar = new TextEditingController();

  TextEditingController idVacunaCtrl = new TextEditingController();
  TextEditingController tituloCCtrl = new TextEditingController();
  TextEditingController fechaInicioCtrl = new TextEditingController();
  TextEditingController fechaFinCtrl = new TextEditingController();
  TextEditingController descripcionCtrl = new TextEditingController();

// Variables de texto
  var tituloV = '';
  var fichaI = '';
  var fechaF = '';
  var descripcion = '';
  //Otras variables
  final _formKeyB = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Regitro nueva campaña'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: keyForm,
            child: formUI(),
          ),
        )));
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUIBusqueda() {
    String nombreT = "";
    return Column(
      children: <Widget>[
        //Aqui van los elementos de nuestro dormulario
        formItemsDesign(
          Icons.person,
          TextFormField(
            onChanged: (value) {
              nombreT = value;
            },
            controller: tituloCCtrl,
            decoration: const InputDecoration(
              labelText: 'Titulo campaña',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z ]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "El titulo es necesario";
              } else if (!regExp.hasMatch(text!)) {
                return "El titulo debe de ser a-z y A-Z";
              }
              return null;
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            if (keyForm.currentState!.validate()) {
              _mostrarAlerte(context);
            }

            /// save();
          },
          child: Container(
            width: 80,
            height: 50,
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
            child: Text(
              "Guardar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            padding: const EdgeInsets.only(top: 6, bottom: 6),
          ),
        )
      ],
    );
  }

  Widget formUI() {
    String nombreV = "";
    return Column(
      children: <Widget>[
        //Aqui van los elementos de nuestro dormulario
        formItemsDesign(
          Icons.person,
          TextFormField(
            onChanged: (value) {
              nombreV = value;
            },
            controller: tituloCCtrl,
            decoration: const InputDecoration(
              labelText: 'Titulo campaña',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z ]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "El titulo es necesario";
              } else if (!regExp.hasMatch(text!)) {
                return "El titulo debe de ser a-z y A-Z";
              }
              return null;
            },
          ),
        ),

        formItemsDesign(
            Icons.phone,
            TextFormField(
              controller: fechaInicioCtrl,
              decoration: const InputDecoration(
                labelText: 'Fecha inicio',
              ),
              keyboardType: TextInputType.datetime,
              maxLength: 1,
              validator: (text) {
                if (text?.length == 0) {
                  return "Este dato es necesario";
                } else if ((text!.length > 1) && text.isNotEmpty) {
                  return "Valor no mayor de un digito!";
                }
                return null;
              },
            )),

        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: fechaFinCtrl,
              decoration: const InputDecoration(
                labelText: 'Fecha fina',
              ),
              keyboardType: TextInputType.datetime,
              maxLength: 2,
              validator: (text) {
                if (text?.length == 0) {
                  return "Este dato es necesario";
                } else if ((text!.length > 2) && text.isNotEmpty) {
                  return "Introduzca una edad valida de no más de digitos !";
                }
                return null;
              },
            )),

        formItemsDesign(
            Icons.email,
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
            child: Text(
              "Guardar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
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
        title: Text('Nuevo registro'),
        content: Text('¿Esta seguro de realizar el este nuevo registro?'),
        actions: [
          MaterialButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('No')),
          MaterialButton(
              onPressed: () {
                save();
                Navigator.of(context).pop();
                _showCustomFlash();
              },
              child: Text('Si'))
        ],
      ),
    );
  }

  _insertarRegistroCampana(BuildContext context) {
    tituloV = tituloCCtrl.text;
    fichaI = fechaInicioCtrl.text;
    fechaF = fechaFinCtrl.text;
    descripcion = descripcionCtrl.text;
/**
 * idVacunaCtrl 
 */
    db.getConnection().then((conn) async {
      var results = await conn.query(
          'insert into campania (titulo,fechaInicio,fechaFin,descripcion,idvacuna) values(?,?,?,?,?)',
          [tituloV, fichaI, fechaF, descripcion, 3]);
      //INSERT INTO `pbdvacuna`.`campania` (`titulo`, `fechaInicio`, `fechaFin`, `descripcion`, `idvacuna`) VALUES ('as', 'as', 'as', 'as', 'as');

      estado = true;
    });

    print('Se hizo el registro?');
    print(estado);
  }

  save() {
    if (keyForm.currentState!.validate()) {
      _insertarRegistroCampana(context);
      print("Nombre ${tituloCCtrl.text}");
      print("Edad ${fechaInicioCtrl.text}");
      print("Descripción ${fechaFinCtrl.text}");
      print("Número dosis ${descripcionCtrl.text}");
      keyForm.currentState!.reset();
    }
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
            colors: [Colors.pink, Colors.red],
          ),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('Exito'),
              content: Text('Registro exitoso!!!!'),
              indicatorColor: Colors.blue,
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('Cerrar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        );
      },
    );
  }

  void _buscarVacuna() {}
}
