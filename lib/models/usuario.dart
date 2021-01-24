import 'package:cloud_firestore/cloud_firestore.dart';

/// Usuario: responsável pelas informações de usuarios.
class Usuario {

  Usuario({this.id, this.nome, this.email, this.password});

  /// recupera informações de usuario do firestore.
  Usuario.fromDocument(DocumentSnapshot document){
    id = document.id;
    nome = document.get('nome') as String;
    email = document.get('email') as String;
  }

  String id;
  String nome;
  String email;
  String password;

  /// senha de confirmação.
  String confirmPassaword;

  /// recupera a instancia do firestore
  DocumentReference get firestoreRef =>  FirebaseFirestore.instance.doc('users/$id');

  /// salva no firebase nome e email.
  Future<void> salvaData() async {
    await firestoreRef.set(toMap());
  }
  /// retorna um map de usuario.
  Map<String, dynamic> toMap() => { 'nome':nome, 'email':email};
}