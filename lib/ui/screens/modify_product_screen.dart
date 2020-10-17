import 'package:firestorecrud/core/constants/decoration.dart';
import 'package:firestorecrud/core/models/product_model.dart';
import 'package:firestorecrud/core/viewmodels/crud_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ModifyProductScreen extends StatefulWidget {
  final Product product;
  ModifyProductScreen({this.product});

  @override
  _ModifyProductScreenState createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {

  final _formKey = GlobalKey<FormState>();
  String productType ;
  String name ;
  String price ;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CrudModel>(context);
    productType = widget.product.img[0].toUpperCase() + widget.product.img.substring(1);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Modify Product Details'),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.product.name,
                  decoration: textFieldDecoration,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Product Title';
                      }else{
                        return null;
                      }
                    },
                    onSaved: (value) => name = value
                ),
                SizedBox(height: 16,),
                TextFormField(
                  initialValue: widget.product.price,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: textFieldDecoration.copyWith(hintText: 'Price'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Product Title';
                      }else{
                        return null;
                      }
                    },
                    onSaved: (value) => price = value
                ),
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
                RaisedButton(
                  splashColor: Colors.red,
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print('Data is valid');
                      await productProvider.updateProduct(Product(name: name,price: price,img: productType.toLowerCase()),widget.product.id);
                      Navigator.pop(context) ;
                    }
                  },
                  child: Text('Modify Product', style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                )
              ],
            )
        ),
      ),
    );
  }
}
