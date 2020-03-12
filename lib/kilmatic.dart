import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'utilies.dart'as ut;
import 'second.dart';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  String _cityentered;

  Future _updatecity(BuildContext context)async{
    Map results =await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context){
       return new second();
      })
    );
    if (results != null && results.containsKey('enter')) {
      _cityentered = results['enter'];
     
      
    }
  }

  void getdata() async{
    Map data = await getWeather(ut.appId, ut.defaultCity);
    print(data.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed:  (){_updatecity(context);},
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella.png',height: 1200.0,width: 490.0,fit: BoxFit.fill,),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text("${_cityentered == null ? ut.defaultCity :_cityentered}",style: style(),),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(30.0, 310.0, 0.0, 0.0),
            child: updateTempWidget(_cityentered),
          )
        ],
      ),
    );
      
    
  }

  Future<Map> getWeather(String id, String cityName) async{
    String apiURL = 'http://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=${ut.appId}&units=imperial';
    http.Response response = await http.get(apiURL);
    
    const JsonCodec Json = json;
    return json.decode(response.body);

  }

  Widget updateTempWidget(String city){
    return new FutureBuilder(
      future: getWeather(ut.appId, city ==null ? ut.defaultCity :city),
      builder: (BuildContext context,AsyncSnapshot<Map> snapshot ){
        if(snapshot.hasData){
          Map content = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(content['main']['temp'].toString()+"F",style: weatherStyle(),),
                  subtitle: new ListTile(
                    title: new Text(
                      "humidity :${content['main']['humidity'].toString()}F\n"
                      "max :${content['main']['temp_max'].toString()}F\n"
                      "min :${content['main']['temp_min'].toString()}F\n",
                      style: style(),
                    )
                  ),
                )
              ],
            ),
          );
        } else{
          return new Container();
        }
        
      }
      );

  }
}
TextStyle style(){
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}
TextStyle weatherStyle(){
  return new TextStyle(
    color: Colors.white,
    fontSize: 49.9,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500
  );
}
//http://api.openweathermap.org/data/2.5/weather?q=london&APPID=c475da90cfd586daad0e9475cc83ced1&units=metric