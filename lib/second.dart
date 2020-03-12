import 'package:flutter/material.dart';
import 'utilies.dart' as util;

class second extends StatelessWidget {
  var _secondcontroller = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: new Text("change city"),
      ),
      body: new Stack(
        children: <Widget>[
         new Center(
           child: new Image.asset("images/white_snow.png",width: 490.0,height: 1200.0,fit: BoxFit.fill,),

         ),
         new ListView(
           children: <Widget>[
             new ListTile(
               title: new TextField(
                 controller: _secondcontroller,
                 decoration: new InputDecoration(
                   hintText: 'enter the city',
                   
                 ),
                 keyboardType: TextInputType.text,
               ),
             ),
             new ListTile(
               title: new FlatButton(
                 onPressed: (){
                   Navigator.pop(context,{
                     'enter' :_secondcontroller.text.isEmpty ? util.defaultCity :_secondcontroller.text
                   });
                 },
                 textColor: Colors.white70,
                 child: new Text("get weather"),
                 color: Colors.redAccent,
               ),
             )
           ],
         )
        ],
      ),
    );
  }
}