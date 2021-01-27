import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labdev/models/cart_manager.dart';
import 'package:labdev/models/product.dart';
import 'package:labdev/models/product_manager.dart';
import 'package:labdev/models/user_manager.dart';
import 'package:labdev/screens/base/base_screen.dart';
import 'package:labdev/screens/cart/cart_screen.dart';
import 'package:labdev/screens/login/login_screen.dart';
import 'package:labdev/screens/product/product_screen.dart';
import 'package:labdev/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,

          /// quando é iniciado o provider já é iniciado o UserManager, ou seja o lazy deve ser false.
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),

        //Sempre que ocorrer mudança de estado do UserManager o irá mudar também no CartManager
        ProxyProvider<UserManager, CartManager>(
          create: (context) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          //operador cascata .. retorna um cartManager
          cartManager..updateUser(userManager),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0, //retirando a elevação
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/base':
              return MaterialPageRoute(
                builder: (context) => BaseScreen(),
              );

            case '/login':
              return MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (context) => CartScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (context) =>
                    ProductScreen(settings.arguments as Product),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              );

            default:
              return MaterialPageRoute(
                builder: (context) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}
