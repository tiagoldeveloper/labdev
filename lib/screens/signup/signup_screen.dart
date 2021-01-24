import 'package:flutter/material.dart';
import 'package:labdev/helpers/validator.dart';
import 'package:labdev/models/user_manager.dart';
import 'package:labdev/models/usuario.dart';
import 'package:provider/provider.dart';

/// Tela de criar conta.
/// SignUpScreen: reponsável criar conta de usuarios.
class SignUpScreen extends StatelessWidget {

  /// usuários
  final Usuario usuario = new Usuario();

  ///Keys
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    ///Corpo base da tela
    return Scaffold(
      key: scaffoldKey,

      /// AppBar
      appBar: AppBar(title: const Text('Criar Conta')),

      ///Central da Tela
      body: Center(

        ///Card da Tela
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),

          ///Formulario da Tela
          child: Form(
            key: formKey,

            /// Gerenciador de estado da tela
            child: Consumer<UserManager>(
              builder: (context, userManager, __) {


                ///LitView da Tela.
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [

                    /// campo nome completo
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome completo'),
                      onSaved: (nome) => usuario.nome = nome,
                      enabled: !userManager.loading,
                      validator: (nome) {
                        if(nome.isEmpty)return 'Campo obrigatório';
                        if(nome.trim().split(' ').length <=1)return 'Preencha seu nome completo';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),


                    /// campo de e-mail
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (email) => usuario.email = email,
                      enabled: !userManager.loading,
                      validator: (email) {
                        if(email.isEmpty)return 'Campo obrigatório';
                        if(!emailValid(email))return 'E-mail inválido';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),


                    /// campo de senha
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      onSaved: (pass) => usuario.password = pass,
                      validator: (pass) {
                        if(pass.isEmpty)return 'Informe a senha';
                        if(pass.length < 6)return 'Senha muito curta';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),


                    /// campo de repita senha
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      onSaved: (pass) => usuario.confirmPassaword = pass,
                      validator: (pass) {
                        if(pass.isEmpty)return 'Informe a senha';
                        if(pass.length < 6)return 'Senha muito curta';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),


                    /// botão Criar Conta
                    SizedBox(
                      height: 44,
                      child: RaisedButton(

                        onPressed:  userManager.loading ? null : () {
                          if(formKey.currentState.validate()){
                            if(usuario.password  != usuario.confirmPassaword){
                              scaffoldKey.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text('Senhas não coincidem!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            formKey.currentState.save();

                            /// chama gerenciador de usuário para criar a conta
                            userManager.signUp(usuario: usuario,

                              /// caso ocorrer erro será mostrado pela snackbar
                              onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao cadastrar: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                              },

                              /// direciona para pagina inicial
                              onSuccess: (){
                                Navigator.of(context).pop();
                              }
                            );
                          }
                        },
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,

                        child: userManager.loading ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) : const Text('Criar Conta', style: TextStyle(fontSize: 18)),
                      ),
                    ),


                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
