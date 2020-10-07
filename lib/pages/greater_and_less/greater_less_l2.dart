import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kidskulapp/pages/greater_and_less/modal_l2.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';




class GreaterLessL2 extends StatefulWidget {
  @override
  _GreaterLessL2State createState() => _GreaterLessL2State();
}

class _GreaterLessL2State extends State<GreaterLessL2> {

  AudioPlayer audioPlayer  = AudioPlayer();

  Future<List<GreaterLessDataL2>> fetchData(http.Client client) async{
    var response = await client.get('http://10.0.2.2:8000/api/GreaterLessL2');
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((greaterlessdata)  => GreaterLessDataL2.fromJson(greaterlessdata)).toList();
    }else{
      throw Exception('faild to get data');
    }
  }


 Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }




  int counter = 0;
  void score(){
    setState(() {
      counter++;
    });
  }


  // int counter2 = 0;
  // void wrong(){
  //   setState(() {
  //     counter2++;
  //   });
  // }

  // void mark(){
  //   setState(() {
  //     isDone = true;
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.orange,
        title:Padding(padding: EdgeInsets.only(top:5, right:40),
           child: Text('Score $counter',
           style: TextStyle(fontWeight: FontWeight.bold),
           ),
          ),
         actions: <Widget>[
          
          Padding(
            padding: EdgeInsets.only(right: 100),
            child:  FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Padding(padding: EdgeInsets.only(top:20),
                      child: Text('level 2'),
                      );
                    }
                }
              }),
            )
        ],
      ),
      
      body:FutureBuilder(
        future: fetchData(http.Client()),
        builder: (BuildContext context , AsyncSnapshot snapshot){
          List<GreaterLessDataL2> data = snapshot.data;
          if(snapshot.hasData){
            return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
      itemBuilder: (context, i){
        return Container(
            width: MediaQuery.of(context).size.width,
            color:Colors.orange,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 200,
                  decoration:BoxDecoration(
                    image:DecorationImage(
                      image:NetworkImage(data[i].img)
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   Text(data[i].question),
                   FaIcon(data[i].isDone?FontAwesomeIcons.checkCircle:FontAwesomeIcons.circle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(onPressed: (){
                      if(data[i].number2 == data[i].answer){
                        score();
                        _incrementCounter();
                          audioPlayer.play(data[i].audio);
                        //  updateData(http.Client(), data[i].isDone = true);
                      }
                      else{
                        audioPlayer.play(data[i].audio2);
                      }
                    }, child: Text("${data[i].number2}") ,color:Colors.white,),
                    RaisedButton(onPressed: (){
                      if(data[i].number == data[i].answer){
                        score();
                        _incrementCounter();
                        audioPlayer.play(data[i].audio);
                     
                      }
                      else{
                        audioPlayer.play(data[i].audio2);
                      }
                    }, child: Text('${data[i].number}'),color:Colors.white,),
                     RaisedButton(onPressed: (){
                       if(data[i].number3 == data[i].answer){
                         score();
                          _incrementCounter();
                           audioPlayer.play(data[i].audio);
                     
                       }
                       else{
                         audioPlayer.play(data[i].audio2);
                       }
                     }, child: Text('${data[i].number3}'),color: Colors.white,)
                  ],
                )
              ],
            ),
          );
      }
        );
          }else if( snapshot.hasError){
            return Center(child:Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}