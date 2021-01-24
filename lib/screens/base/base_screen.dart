import 'package:flutter/material.dart';
import 'package:labdev/common/custom_drawer/custom_drawer.dart';
import 'package:labdev/common/custom_drawer/custom_drawer_header.dart';
import 'package:labdev/models/page_manager.dart';
import 'package:labdev/screens/login/login_screen.dart';
import 'package:labdev/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [

          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),

          ProductsScreen(),

          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home4'),
            ),
          ),
          Container(
            color: Colors.red,
          ),
          Container(color: Colors.yellow,),
          Container(color: Colors.green,),
        ],
      ),
    );
  }
}
