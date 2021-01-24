import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:labdev/helpers/firebase_errors.dart';
import 'package:labdev/models/usuario.dart';

/// UserManager: responsável por gerenciar usuários.
class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  Usuario usuario;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => usuario !=null;


  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  /// firebase auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// banco de dados firebase.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  /// metodo responsável por realizar login.
  Future<void> signIn({Usuario usuario, Function onFail, Function onSuccess}) async{
    loading = true;
    if(this.usuario == null){
      try{

        final UserCredential credential = await auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.password);
         await _loadCurrentUser(user: credential.user);

        onSuccess();

      } on FirebaseAuthException catch(e){
        onFail(getErrorString(e.code));
      }

      loading = false;
    }
  }


  /// metodo responsável por criar uma conta.
  Future<void> signUp({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try{
      UserCredential user = await auth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.password);

      usuario.id = user.user.uid;
      await usuario.salvaData();

      onSuccess();
      loading = false;
    } on FirebaseAuthException  catch(e){
      onFail(getErrorString(e.code));
      loading = false;
    }
  }


  /// metodo reponsável por carregar as informações de usuario quando inicial classe.
  Future<void> _loadCurrentUser({User user}) async {
    final User userCurrent = user ?? auth.currentUser;
    if(userCurrent !=null){
     final DocumentSnapshot docUser = await firestore.collection('users').doc(userCurrent.uid).get();
      usuario = Usuario.fromDocument(docUser);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
     await auth.signOut();
     usuario = null;
     notifyListeners();
  }

}