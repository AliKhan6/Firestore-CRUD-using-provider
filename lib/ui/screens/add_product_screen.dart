import 'package:firestorecrud/core/constants/decoration.dart';
import 'package:firestorecrud/core/models/product.dart';
import 'package:firestorecrud/core/viewmodels/produts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddProductScreen extends StatefulWidget {
  final provider;
  AddProductScreen({this.provider});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  String productType = 'Bag';

  String name ;

  String price ;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Add Product'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: productFieldDecoration,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Product title is necessary';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: productFieldDecoration.copyWith(hintText: 'Price'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Price is necessary';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) => price = value,
                ),
                SizedBox(height: 16,),
                DropdownButton<String>(
                  value: productType,
                    onChanged: (String newValue){
                      setState(() {
                        productType = newValue;
                      });
                    },
                    items: <String>['Bag', 'Computer', 'Dress', 'Phone','Shoes']
                        .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          );
                        }).toList(),
                ),
                SizedBox(height: 16,),
                RaisedButton(
                  splashColor: Colors.red,
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      print('Data is valid');
                      await productProvider.addProduct(Product(name: name, price: price, img: productType.toLowerCase()));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Product', style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                )
              ],
            )
        ),
      ),
    );
  }
}
