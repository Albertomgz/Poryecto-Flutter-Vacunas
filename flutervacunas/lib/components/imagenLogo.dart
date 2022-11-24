// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/constant.dart';

// ignore: camel_case_types
class imagenLogo extends StatelessWidget {
  const imagenLogo({Key? key, required this.imgnom}) : super(key: key);
  final String imgnom;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Image.asset(
              imgnom,
              alignment: Alignment.topCenter,
              scale: 1.5,
            ),
          ),
        ),
        iconBackButton(context),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
