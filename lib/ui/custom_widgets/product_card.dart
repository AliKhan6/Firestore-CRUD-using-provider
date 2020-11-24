import 'package:firestorecrud/core/models/product.dart';
import 'package:firestorecrud/ui/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product productDetail;
  final provider;
  ProductCard({this.productDetail,this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(
          product: productDetail,
          provider: provider,
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