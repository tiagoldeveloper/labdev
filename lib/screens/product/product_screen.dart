import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:labdev/models/cart_manager.dart';
import 'package:labdev/models/product.dart';
import 'package:labdev/models/user_manager.dart';
import 'package:labdev/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {

   final primaryColor =  Theme.of(context).primaryColor;

    ///adicionado o ChangeNotifierProvider.value por motivo de não precisar do product na app inteira.
   ///Ou seja o unico lugar que faz sentido é na ProductScreen.
   ///
   ///
   ///
   /// Diferença do ChangeNotifierProvider e ChangeNotifierProvider.value ?
   ///
   /// ChangeNotifierProvider: cria um objeto inteiro
   ///
   ///
   /// ChangeNotifierProvider.value: é para fornecer um objeto, exemplo eu já tenho um product no construtor dessa classe, então
   /// logo faz sentido eu usar um ChangeNotifierProvider.value pegando o objeto product para gerenciar o mesmo.
   ///
   ///
   ///
    return ChangeNotifierProvider.value(
      value: product,///product que sera gerenciado pelo ChangeNotifierProvider.value
      child: Scaffold(


        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(

          children: [

            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                 images: product.images.map((url) {
                   return NetworkImage(url);
                }).toList(),

                dotSize: 5,
                dotSpacing: 15,
                dotColor: primaryColor,
                dotBgColor: Colors.transparent,
                autoplay: false,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20,
                      ),
                    ),
                  ),


                  Text(
                    'R\$ 19.90',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),


                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),


                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((s)  {
                      return SizeWidget(size: s);
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: RaisedButton(
                            onPressed: product.selectedSize !=null ? () {
                              if(userManager.isLoggedIn) {
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              }else{
                                Navigator.of(context).pushNamed('/login');
                              }

                            }: null,


                            color: primaryColor,
                            textColor: Colors.white,
                            child: Text(
                                userManager.isLoggedIn ? 'Adicionar ao Carrinho'
                                    : 'Entre para Comprar'
                            ),
                          ),
                        );
                      },
                    )
,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}





















