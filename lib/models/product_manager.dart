import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:labdev/models/product.dart';

/// ProductManager: responsável por gerenciar os produtos
class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  String _search = '';

  List<Product> allProducts = [];

  final FirebaseFirestore storage = FirebaseFirestore.instance;

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredProducts;
  }

  ///carregas lista de produtos
  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapshot =
        await storage.collection('products').getDocuments();
    allProducts = snapshot.docs
        .map((document) => Product.fromDocument(document))
        .toList();
    notifyListeners();
  }
}
