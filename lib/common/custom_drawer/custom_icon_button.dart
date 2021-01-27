import 'package:flutter/material.dart';


class CustomIconButton extends StatelessWidget {

  const CustomIconButton({this.iconData, this.color, this.onTap});

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    //InkWell tem animação, so que o pai deve ser um material para ocorrer a animação.
    //GestureDetector detector não tem animação
    //ClipRRect sempre para criar formato arredondado

    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
