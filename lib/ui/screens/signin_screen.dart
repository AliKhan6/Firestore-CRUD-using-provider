import 'package:firestorecrud/core/constants/decoration.dart';
import 'package:firestorecrud/core/emun/auth_status.dart';
import 'package:firestorecrud/core/services/firebase_auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthHelper>(context);
    return user.status == AuthStatus.Authenticating
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Text('Logo Name\n \t\t Here',style: TextStyle(color: Colors.red, fontSize: 35,fontWeight: FontWeight.w700),),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: authFieldDecoration,
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
                      onChanged: (value) => _password = value,
                      obscureText: true,
                      decoration: authFieldDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock)),
                      validator: (value){
                        if(value.isEmpty) {
                          return 'password is required';
                        }else {
                          return null;
                        }
                      },),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                            onTap: (){},
                            child: Text('Forgot Password'))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: FlatButton(
                          color: Colors.red,
                          child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 17),),
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              await user.signIn(_email, _password);
                              Navigator.pushReplacementNamed(context, 'home_screen');
                            }
                          }),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, 'sign_up_screen');
                            },
                            child: Text('Sign Up',style: TextStyle(color: Colors.red),))
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