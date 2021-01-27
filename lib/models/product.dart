import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:labdev/models/item_size.dart';

class Product extends ChangeNotifier{

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get('name') as String;
    description = document.get('description') as String;
    images = List<String>.from(document.get('images') as List<dynamic>);

    sizes = (document.get('sizes') as List<dynamic> ?? []).map(
          (size) => ItemSize.fromMap(size as Map<String, dynamic>)).toList();
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;


  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value){
    _selectedSize = value;
    notifyListeners();
  }

  bool get hasStock {
    return totalStock > 0;
  }

  int get totalStock {
    int total = 0;
    for(final size in sizes){
      total +=size.stock;
    }
    return total;
  }

  ItemSize findSize(String name) {
    try{
      return sizes.firstWhere((s) => s.name == name);
    }catch (e){
      return null;
    }
  }
}













