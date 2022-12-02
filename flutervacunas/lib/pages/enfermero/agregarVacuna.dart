import 'package:flutter/material.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flash/flash.dart';
import 'package:flutervacunas/widgets/constant.dart';

class AgregarVacuna extends StatefulWidget {
  const AgregarVacuna({
    Key? key,
  });

  @override
  State<AgregarVacuna> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AgregarVacuna> {
  var db = Mysql();
  var estado = false;
  //Controlares para guardar los valores escritos para las cajas de texto
  TextEditingController NombreVCtrl = new TextEditingController();
  TextEditingController NumDosisCtrl = new TextEditingController();
  TextEditingController TipoCtrl = new TextEditingController();
  TextEditingController DescripcionCtrl = new TextEditingController();
  //declaramos otra variable conn la clase GlobalKey para poder manejar el formulario
  GlobalKey<FormState> keyForm = new GlobalKey();
  var nombreV = '';
  var numDosis = '';
  var tipo = '';
  var descripcion = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro vacunas'),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: keyForm,
          child: formUI(),
        ),
      )),
    );
  }

  _insertarRegistroV(BuildContext context) {
    nombreV = NombreVCtrl.text;
    numDosis = NumDosisCtrl.text;
    tipo = TipoCtrl.text;
    descripcion = DescripcionCtrl.text;

    db.getConnection().then((conn) async {
      var results = await conn.query(
          'insert into vacuna (nombre,num_dosis,descripcion,tipo) values(?,?,?,?)',
          [nombreV, numDosis, descripcion, tipo]);
      //INSERT INTO `pbdvacuna`.`vacuna` (`nombre`, `num_dosis`, `descripcion`, `tipo`, `rango`) VALUES ('as', 'a', 'aaa', 'a', 'aa');

//var result = await conn.query('insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]);
      estado = true;
    });

    print('Se hizo el registro?');
    print(estado);
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    String nombreV = "";
    return Column(
      children: <Widget>[
        const Text(
          'Formulario para registrar vacuna',
          style: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'roboto',
              fontWeight: FontWeight.w800,
              fontSize: 18),
          textAlign: TextAlign.center,
        ),
        //Aqui van los elementos de nuestro dormulario
        formItemsDesign(
          Icons.title,
          TextFormField(
            onChanged: (value) {
              nombreV = value;
            },
            controller: NombreVCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z0-9_.-]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "El nombre es necesario";
              } else if (!regExp.hasMatch(text!)) {
                return "El nombre puede contener números, letras, punto o guiones.";
              }
              return null;
            },
          ),
        ),

        formItemsDesign(
            Icons.tag,
            TextFormField(
              controller: NumDosisCtrl,
              decoration: const InputDecoration(
                labelText: 'Numero de dosis',
              ),
              keyboardType: TextInputType.number,
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
            Icons.label,
            TextFormField(
              controller: TipoCtrl,
              decoration: const InputDecoration(
                labelText: 'Tipo',
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
            Icons.description,
            TextFormField(
              controller: DescripcionCtrl,
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
                      Icons.save,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: "Guardar",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  save() {
    if (keyForm.currentState!.validate()) {
      _insertarRegistroV(context);
      print("Nombre ${NombreVCtrl.text}");
      print("Edad ${TipoCtrl.text}");
      print("Descripción ${DescripcionCtrl.text}");
      print("Número dosis ${NumDosisCtrl.text}");
      keyForm.currentState!.reset();
    }
  }

//dialogo de alerta
  void _mostrarAlerte(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Nuevo registro',
          style: TextStyle(
              color: Color.fromARGB(255, 7, 32, 255),
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        content: Text('¿Esta seguro de realizar el este nuevo registro?',
            style: TextStyle(color: Colors.black)),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No', style: TextStyle(color: Colors.red))),
          OutlinedButton(
              onPressed: () {
                save();
                Navigator.of(context).pop();
                _showCustomFlash();
              },
              child: Text('Si', style: TextStyle(color: Colors.blue)))
        ],
      ),
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
              content: Text('Registro exitoso!!!!'),
              indicatorColor: Colors.blue,
              icon: Icon(
                Icons.check,
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

  Form fomularioRegistro() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/agregarV.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Nuevo registro',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 40,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Nombre",
                    labelStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kLightPrimaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: ImageIcon(
                      AssetImage('assets/images/vacunas.png'),
                      size: 30,
                      color: Color.fromRGBO(0, 40, 110, 1),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 40,
              child: TextField(
                keyboardType: TextInputType.name,
                //controller: _textEditingControllerNombre,
                decoration: InputDecoration(
                    labelText: "Número dosis",
                    labelStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 40, 110, 1), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: ImageIcon(
                      AssetImage('assets/images/numero.png'),
                      size: 30,
                      color: Color.fromRGBO(0, 40, 110, 1),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 40,
              child: TextField(
                keyboardType: TextInputType.name,
                // controller: _textEditingControllerAP,
                decoration: InputDecoration(
                    labelText: "Edad aplicación",
                    labelStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 40, 110, 1), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: ImageIcon(
                      AssetImage('assets/images/edad.png'),
                      size: 30,
                      color: Color.fromRGBO(0, 40, 110, 1),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 120,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLength: 200,
                maxLines: null,
                // controller: _textEditingControllerAM,
                decoration: InputDecoration(
                    labelText: "Descripcion",
                    labelStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(0, 40, 110, 1), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: Icon(
                      Icons.format_align_justify,
                      size: 30,
                      color: Color.fromRGBO(0, 40, 110, 1),
                    )),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 50),
                      primary: Color.fromRGBO(0, 230, 118, 1),
                    ),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Agregar registro'),
                        content: const Text(
                            '¿Esta seguro de agregar esta información?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('Si'),
                          ),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.save,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void _actualizarDatos(BuildContext context) {}
}
