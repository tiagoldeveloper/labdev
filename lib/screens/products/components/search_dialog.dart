import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// a vantagem de usar o Stack é porque pode posicionar livremente na tela.
    return Stack(
      /// a
      children: [
        ///pode posicionar em qualquer lado da tela
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(

                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.green[700],
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
