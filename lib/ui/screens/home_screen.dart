import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestorecrud/core/models/product.dart';
import 'package:firestorecrud/core/viewmodels/produts_view_model.dart';
import 'package:firestorecrud/ui/custom_widgets/bottom_navigation_bar.dart';
import 'package:firestorecrud/ui/custom_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_product_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(
            provider: productProvider,
          ))),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: <Widget>[
          GestureDetector(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.only(right: 12.0,top: 0.0),
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                products = snapshot.data.docs.map((doc) => Product.fromJson(doc.data(), doc.id)).toList();
                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index){
                      return ProductCard(productDetail: products[index],provider: productProvider,);
                    }
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
        }
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(0)
    );
  }
}


