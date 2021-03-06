import 'package:flutter/material.dart';
import 'package:labdev/common/custom_drawer/custom_icon_button.dart';
import 'package:labdev/models/cart_product.dart';

class CartTile extends StatelessWidget {

  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product.images.first),
            ),

            Expanded(
               child: Padding(
                 padding: const EdgeInsets.only(left: 16),
                 child: Column(
                   crossAxisAlignment:CrossAxisAlignment.start,
                   children: [
                     Text(
                       cartProduct.product.name,
                       style: const TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: 17.0,
                       ),
                     ),
                     Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                       child: Text(
                         'Tamanho : ${cartProduct.size}',
                         style: const TextStyle(fontWeight: FontWeight.w300),
                       ),
                     ),
                     Text(
                       'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                       style: TextStyle(
                         color: Theme.of(context).primaryColor,
                         fontSize: 16.0,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),
            ),

            Column(
              children: [
                CustomIconButton(
                  iconData: Icons.add,
                  color: Theme.of(context).primaryColor,
                  onTap: () {

                  },
                ),
                Text(
                  '${cartProduct.quantity}',
                   style: const TextStyle(fontSize: 20),
                ),
                CustomIconButton(
                  iconData: Icons.remove,
                  color: Theme.of(context).primaryColor,
                  onTap: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}























