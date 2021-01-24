import 'package:flutter/material.dart';
import 'package:labdev/common/custom_drawer/custom_drawer.dart';
import 'package:labdev/models/product.dart';
import 'package:labdev/models/product_manager.dart';
import 'package:labdev/screens/products/components/product_list_tile.dart';
import 'package:labdev/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';


class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
             final search = await showDialog<String>(context: context, builder: (context) => SearchDialog(),);

             if(search !=null){
               context.read<ProductManager>().search = search;
             }
            },
          )
        ],
      ),

      body: Consumer<ProductManager>(
        builder: (_, produtosManager, __) {
          final filteredProducts = produtosManager.filteredProducts;
          return  ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
                final Product product = filteredProducts[index];
                return ListTile(
                  title: ProductListTile(product),
                );
            },
          );
        },
      ),
    );
  }
}
