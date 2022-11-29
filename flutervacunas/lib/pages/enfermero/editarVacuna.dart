import 'package:flutervacunas/pages/enfermero/vacunas.dart';
import 'package:flutter/material.dart';
import 'package:flutervacunas/database/mysql.dart';
import 'package:flash/flash.dart';
import 'package:flutervacunas/widgets/constant.dart';
import 'package:getwidget/getwidget.dart';

class EditarVacuna extends StatefulWidget {
  final String idVacu;
  const EditarVacuna({Key? key, required this.idVacu});

  @override
  State<EditarVacuna> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditarVacuna> {
  var db = Mysql();

  var estado = false;
  //Controlares para guardar los valores escritos para las cajas de texto
  TextEditingController NombreVCtrl = new TextEditingController();
  TextEditingController NumDosisCtrl = new TextEditingController();
  TextEditingController TipoCtrl = new TextEditingController();
  TextEditingController DescripcionCtrl = new TextEditingController();
  //declaramos otra variable conn la clase GlobalKey para poder manejar el formulario
  GlobalKey<FormState> keyForm = new GlobalKey();
  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    NombreVCtrl.dispose();
    super.dispose();
  }

  var nombreV = '';
  var numDosis = '';
  var tipo = '';
  var descripcion = '';

  final _formKey = GlobalKey<FormState>();
  String? get idVacu => idVacu;

  @override
  Widget build(BuildContext context) {
    db.getConnection().then((conn) async {
      var results = await conn
          .query('SELECT * FROM vacuna where idvacuna=?', [widget.idVacu]);

      results.forEach((row) {
        NombreVCtrl.text = row[1];
        NumDosisCtrl.text = row[2].toString();
        DescripcionCtrl.text = row[3];
        TipoCtrl.text = row[4];
      });
      // Finally, close the connection
      conn.close();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar vacuna'),
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

  _editarRegistroV(BuildContext context) {
    nombreV = NombreVCtrl.text;
    numDosis = NumDosisCtrl.text;
    tipo = TipoCtrl.text;
    descripcion = DescripcionCtrl.text;

    db.getConnection().then((conn) async {
      var results = await conn.query(
          'update vacuna set nombre=?,num_dosis=?,descripcion=?,tipo=? where idvacuna=?',
          [nombreV, numDosis, descripcion, tipo, widget.idVacu]);
    });
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Text(
          widget.idVacu,
        ),
        const Text(
          'Formulario para editar vacuna',
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
            controller: NombreVCtrl,
            decoration: const InputDecoration(
              labelText: 'Nombre',
            ),
            validator: (text) {
              String pattern = r'(^[a-zA-Z0-9_.-]*$)';
              RegExp regExp = new RegExp(pattern);

              if (text?.length == 0) {
                return "El nombre es necesario";
              } /*else if (!regExp.hasMatch(text!)) {
                return "El nombre puede contener números, letras, punto o guiones.";
              }*/
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
            ),
          ),
        ),
        Container(
          width: 210,
          height: 50,
          child: GFButton(
            color: Colors.red,
            onPressed: () {
              _mostrarAlerte2(context, widget.idVacu, db);
            },
            text: 'Eliminar',
            textColor: Colors.black,
            icon: Icon(Icons.delete_outline, color: Colors.black),
          ),
        ),
      ],
    );
  }

  void _mostrarAlerte2(BuildContext context, String idVacu, Mysql db) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar registro'),
        content: Text('¿Esta seguro de eliminar ese registro de vacuna?'),
        actions: [
          MaterialButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('No')),
          MaterialButton(
              onPressed: () {
                _elimimarVacuna(idVacu, db);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListVacunas(),
                  ),
                );
                _showCustomFlashE();
              },
              child: Text('Si'))
        ],
      ),
    );
  }

  save() {
    if (keyForm.currentState!.validate()) {
      _editarRegistroV(context);
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
        title: Text('Editar registro'),
        content: Text('¿Esta seguro de realizar los cambios en el registro?'),
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

  void _showCustomFlashE() {
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
              content: Text('¡Eliminación exitoso!'),
              indicatorColor: Colors.blue,
              icon: Icon(
                Icons.done_outline,
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
              content: Text('¡Edición exitosa!'),
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

  void _elimimarVacuna(String idVacu, Mysql db) {
    print('Id de la vacuna a eliminar');
    print(idVacu);

    //DELETE FROM `pbdvacuna`.`campania` WHERE (`idcampania` = '16');
    db.getConnection().then((conn) async {
      var results =
          await conn.query('DELETE FROM vacuna WHERE idvacuna = ?', [idVacu]);
      conn.close();
    });
  }
}
