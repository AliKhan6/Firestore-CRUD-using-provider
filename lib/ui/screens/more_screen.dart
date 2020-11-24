import 'package:firestorecrud/core/services/firebase_auth_helper.dart';
import 'package:firestorecrud/core/viewmodels/more_data_view_model.dart';
import 'package:firestorecrud/ui/custom_widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moreProvider = Provider.of<MoreDataViewModel>(context);
    final userProvider = Provider.of<FirebaseAuthHelper>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('More',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: GridView.builder(
                    itemCount: moreProvider.moreScreenData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          if(index == 0){
                            Navigator.pushNamed(context, 'profile_screen');
                          }else{
                            userProvider.signOut();
                            Navigator.pushReplacementNamed(context, 'sign_in_screen');
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 3.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    maxRadius: 35,
                                    backgroundColor: Colors.red[100],
                                    child: Center(child: Icon(moreProvider.moreScreenData[index].icon,color: Colors.red,size: 30,)),
                                  ),
                                  SizedBox(height: 20,),
                                  Text('${moreProvider.moreScreenData[index].name}')
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ]
          )
        ),
          bottomNavigationBar: CustomBottomNavigationBar(4)
      ),
    );
  }
}