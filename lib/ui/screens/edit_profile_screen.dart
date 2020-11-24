import 'package:firestorecrud/core/emun/auth_status.dart';
import 'package:firestorecrud/core/models/profile.dart';
import 'package:firestorecrud/core/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  final Profile profile;
  EditProfileScreen({this.profile});

  final _formKey = GlobalKey<FormState>();
  String _email, _name, _phoneNo, _address;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileViewModel>(context);
    return profileProvider.status == AuthStatus.Authenticating
        ?
    Scaffold(
      body: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    )
        :
    Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height*0.83,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          // This function will upload image to firebase storage and giving us url
                          profileProvider.uploadImageToStorage();
                        },
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundColor: Colors.white,
                          ///
                          /// image url come from profile view model class using notifyListeners
                          ///
                          child:
                          /// When image url is null then show already given profile image in time of sign up
                          profileProvider.imageUrl == null ?
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(profile.imageUrl,fit: BoxFit.cover,)
                          ):
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(profileProvider.imageUrl,fit: BoxFit.cover,)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      /// All text fields for editing the profile value...... Having initial value
                      ///
                      TextFormField(
                        initialValue: profile.name,
                        onChanged: (value) => _name = value,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        initialValue: profile.email,
                        onChanged: (value) => _email = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        initialValue: profile.phoneNo,
                        onChanged: (value) => _phoneNo = value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        initialValue: profile.address,
                        onChanged: (value) => _address = value,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: Colors.red,
                    child: FlatButton(
                      onPressed: () async{
                        print(profile.imageUrl);
                        print(profileProvider.imageUrl);
                        if (_formKey.currentState.validate()) {
                          await profileProvider.editProfile(
                            /// if value is not changed then give previous value otherwise provide new value
                            ///
                              Profile(
                                id: profile.id,
                                  name: _name == null ? profile.name : _name,
                                  email: _email == null ? profile.email : _email,
                                  imageUrl: profileProvider.imageUrl == null ? profile.imageUrl : profileProvider.imageUrl,
                                phoneNo: _phoneNo == null ? profile.phoneNo : _phoneNo,
                                address: _address == null ? profile.address : _address,
                              ),
                              profile.id);
                          profileProvider.imageUrl = null;
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 17),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
