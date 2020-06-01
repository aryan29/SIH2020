import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
class UserProfile1 extends StatefulWidget {
  UserProfile1({Key key}) : super(key: key);

  @override
  _UserProfile1State createState() => _UserProfile1State();
}

class _UserProfile1State extends State<UserProfile1> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         child:Stack(
           children: <Widget>[
             Positioned(
               top:250,

              child: Container(
                width: MediaQuery.of(context).size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Text("Aryan Khandelwal",style:TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold))
                ],)

               ),
             ),
             Positioned(
              //  top:0.0,
              //  left:0.0,
               child: ClipPath(
                 clipper:ArcClipper(),
                 child:Container(
                   height:300,
                   color:Colors.cyan,

                 )

             ),),
             Positioned(
               top:110,
               left:MediaQuery.of(context).size.width/2-50,
               child:Container(
                 height:100,width:100,
                 decoration: BoxDecoration(
                   boxShadow: [BoxShadow(color:Colors.cyan.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0,0))],
                   borderRadius: BorderRadius.circular(30.0),
                   border: Border.all(color: Colors.white,width:5.0,style: BorderStyle.solid),
                   color:Colors.green,
                   image:DecorationImage(
                     fit:BoxFit.cover,
                     image: NetworkImage("https://webstockreview.net/images/bandana-clipart-gangsta-15.jpg")
                     )
                     ,)
                     ,)
                     ,),
           ],


         )
       )
    );
  }
}
