import 'package:flutter/material.dart';
import 'package:labdev/helpers/validator.dart';
import 'package:labdev/models/user_manager.dart';
import 'package:labdev/models/usuario.dart';
import 'package:provider/provider.dart';

/// Tela de login
/// LoginScreen: reponsável por logar no aplicativo
///
class LoginScreen extends StatelessWidget {


  ///Campos: usuario e senha
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  ///Keys states
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //OBS: cada compontente tem uma chave, exemplo TextFormFiedl, Scaffold.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            textColor: Colors.white,
            child: const Text(
              'CRIAR CONTA',
               style: TextStyle(
                 fontSize: 14,
               ),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey, //ativa o formKey

            child: Consumer<UserManager>(
              builder: (context, userManegar, child) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true, //menor altura posivel

                  children: [


                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      enabled: !userManegar.loading,
                      autocorrect: false, //auto correção
                      validator: (email) {
                        if (!emailValid(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),


                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false, //auto correção
                      controller: passController,
                      enabled: !userManegar.loading,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6) {
                          return 'Senha inválida';
                        }
                        return null;
                      },
                    ),

                    //widget do consumer, ou seja quando for rebuildar não rebuilda esse widget
                    child,



                    const SizedBox(height: 16),


                    SizedBox(
                      height: 44,
                      child: RaisedButton(

                        onPressed: userManegar.loading ? null : () {
                          if (formKey.currentState.validate()) {
                            userManegar.signIn(
                              usuario: Usuario(email: emailController.text,password: passController.text,),
                              onFail: (e) {
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao entrar: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSuccess: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: userManegar.loading ?
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white)
                        ) :
                        const Text('Entrar', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                );
              },


              //esse widget não é atualizado
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Esqueci minha senha',
                  ),
                ),
              ),


            ),
          ),
        ),
      ),
    );
  }
}
