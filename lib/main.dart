import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
MaterialApp(
title: "Weather App",
  home:Home(),
)
);
class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home>{

  var temp;
  var desc;
  var currently;
  var humidity;
  var windspeed;


  Future getWeather (String city) async {
    http.Response response= await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=' +city+'&APPID=04315887768a9d45ad1b98c3705ae716'));
    var results=jsonDecode(response.body);
    setState(() {
      this.temp=(results['main']['temp']-273.15).toStringAsFixed(2);
      this.desc=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windspeed=results['wind']['speed'];
    });
  }
  @override
  void initState(){
    super.initState();
    this.getWeather("Delhi");
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/index.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height /3,
            width : MediaQuery.of(context).size.width ,
            //color: Colors.blueGrey,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                  "Currently in Delhi" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,

                    ),
    ),


              ),
          Text(
             temp != null ? temp.toString() +"\u00b0"+"C" : "Loading",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              currently != null ? currently.toString() : "Loading",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
      ],
    ),
   ),
          Expanded(

              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text (temp != null ? temp.toString() +"\u00b0"+"C" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(desc != null ? desc.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity"),
                      trailing: Text(humidity != null ? humidity.toString() : "Loading",),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(windspeed != null ? windspeed.toString() : "Loading",),
                    ),
                  ],
                ),

          ),
          )
        ],
      ),
    );
  }
}