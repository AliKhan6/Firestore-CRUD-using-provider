import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestorecrud/core/models/product_model.dart';
import 'package:firestorecrud/core/viewmodels/crud_model.dart';
import 'package:firestorecrud/ui/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CrudModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context,'add_products'),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home Screen')),
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
                      return ProductCard(productDetail: products[index]);
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
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product productDetail;
  ProductCard({this.productDetail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(
          product: productDetail,
        )));
      },
      child: Padding(
          padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Hero(
                    tag: productDetail.id,
                    child: Image.asset('images/${productDetail.img}.jpg',height: MediaQuery.of(context).size.height * 0.35,),
                ),
                Padding(
                    padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        productDetail.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        '${productDetail.price} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
