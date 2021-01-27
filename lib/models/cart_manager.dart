import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:labdev/models/cart_product.dart';
import 'package:labdev/models/product.dart';
import 'package:labdev/models/user_manager.dart';
import 'package:labdev/models/usuario.dart';

class CartManager {

  List<CartProduct> items =[];

  Usuario usuario;

  Future<void> updateUser(UserManager userManager) async {
    usuario = userManager.usuario;

    items.clear();

    if(usuario !=null){
      await _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot snapshot = await usuario.cartRefence.getDocuments();
   items = snapshot.documents.map((e) => CartProduct.fromDocument(e)).toList();
  }
  void addToCart(Product product){
    try{
      final e = items.firstWhere((p) => p.stackable(product));
      e.quantity++;

    }catch (e){
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      usuario.cartRefence.add(cartProduct.toCartItemMap());
    }
  }
}

