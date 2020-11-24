import 'package:firestorecrud/core/emun/auth_status.dart';
import 'package:firestorecrud/core/services/firebase_auth_helper.dart';
import 'package:firestorecrud/core/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {

  // validate form using form key
  final _formKey = GlobalKey<FormState>();
  // variables required for profile info
  String _password;
  String _email, _name, _phoneNo, _address;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FirebaseAuthHelper>(context);
    final profileProvider = Provider.of<ProfileViewModel>(context);
    return authProvider.status == AuthStatus.Authenticating
        ?
    Scaffold(
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    )
        :
    Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                Text('Signup',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    profileProvider.uploadImageToStorage();
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 3.0,
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.white,
                      ///
                      /// image url come from profile view model class using notifyListeners
                      ///
                      child:
                          /// When image url is null then show Camera Icon
                      profileProvider.imageUrl == null ?
                      Icon(Icons.camera_alt,size: 30, color: Colors.red[200],) :
                      Material(
                          borderRadius: BorderRadius.circular(50),
                          /// Otherwise show image using image network Widget
                          child: Image.network(profileProvider.imageUrl)),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Text('Add Picture',style: TextStyle(fontSize: 13),),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value) => _name = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
                      labelText: "Full Name"),
                  validator: (value){
                    if(value.isEmpty) {
                      return 'name is required';
                    }else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                    onChanged: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
                        labelText: "Email Address"),
                    validator: (value){
                      if(value.isEmpty) {
                        return 'email is required';
                      }else {
                        return null;
                      }
                    },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value) => _phoneNo = value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
                      labelText: "Phone Number"),
                  validator: (value){
                    if(value.isEmpty) {
                      return 'Phone no is required';
                    }else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value) => _address = value,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
                      labelText: "location"),
                  validator: (value){
                    if(value.isEmpty) {
                      return 'location is required';
                    }else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                    onChanged: (value) => _password = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
                        labelText: "Password"),
                    validator: (value){
                      if(value.isEmpty) {
                        return 'password is required';
                      }else {
                        return null;
                      }
                  },),
                SizedBox(height: 20,),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: FlatButton(
                    color: Colors.red,
                      child: Text("SignUp",style: TextStyle(color: Colors.white,fontSize: 17),),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          await authProvider.signUp(
                            email: _email,
                            password: _password,
                            name: _name,
                            phoneNo: _phoneNo,
                            location: _address,
                            imageUrl: profileProvider.imageUrl,
                            provider: profileProvider
                          );
                          ///
                          /// Make image url null again to check it in edit profile screen for taking new image for profile
                          profileProvider.imageUrl = null;
                          Navigator.pushReplacementNamed(context, 'home_screen');
                        }
                      }),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account? '),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'sign_in_screen');
                        },
                        child: Text('Sign In',style: TextStyle(color: Colors.red),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}