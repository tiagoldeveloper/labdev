import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get('name') as String;
    description = document.get('description') as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
  }

  String id;
  String name;
  String description;
  List<String> images;

}