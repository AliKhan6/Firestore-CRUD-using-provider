import 'package:firestorecrud/core/models/product_model.dart';
import 'package:firestorecrud/core/viewmodels/crud_model.dart';
import 'package:firestorecrud/ui/screens/modify_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
              icon: Icon(Icons.delete_forever),
              onPressed: () async{
                await productProvider.removeProduct(product.id);
                Navigator.pop(context);
              }
          ),
          IconButton(
            iconSize: 35,
              icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => ModifyProductScreen(product: product)));
              }
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: product.id,
            child: Image.asset('images/${product.img}.jpg',
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            product.name,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '${product.price} \$',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: Colors.orangeAccent),
          )
        ],
      ),
    );
  }
}
