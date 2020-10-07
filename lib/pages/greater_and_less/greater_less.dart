import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kidskulapp/pages/greater_and_less/greater_less_l2.dart';
import 'package:kidskulapp/pages/greater_and_less/model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Greater_and_Less extends StatefulWidget {
  @override
  _Greater_and_LessState createState() => _Greater_and_LessState();
}

class _Greater_and_LessState extends State<Greater_and_Less> {

  AudioPlayer audioPlayer  = AudioPlayer();

  Future<List<GreaterLessData>> fetchData(http.Client client) async{
    var response = await client.get('http://10.0.2.2:8000/api/GreaterLess');
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((greaterlessdata)  => GreaterLessData.fromJson(greaterlessdata)).toList();
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


  final _controller = ScrollController();
  final _height = 400.0;

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


 bool isDone = false;

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
                      return snapshot.data >= 17?RaisedButton(onPressed:()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GreaterLessL2())),
                      child: Text('Go level2')
                      ):Padding(padding: EdgeInsets.only(top:20),
                      child: Text('level 1'),
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
          List<GreaterLessData> data = snapshot.data;
          if(snapshot.hasData){
            return ListView.builder(
                controller: _controller,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
      itemBuilder: (context, i){
        return Container(
            width: MediaQuery.of(context).size.width,
            color:Colors.orange,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 400,
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
                      _animateToIndex(i+1);
                      setState(() {
                        isDone = true;
                      });
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
                      _animateToIndex(i+1);
                      if(data[i].number == data[i].answer){
                        score();
                        _incrementCounter();
                        audioPlayer.play(data[i].audio);
                        setState(() {
                          isDone = true;
                        });
                     
                      }
                      else{
                        audioPlayer.play(data[i].audio2);
                        setState(() {
                          isDone = true;
                        });
                      }
                    }, child: Text('${data[i].number}'),color:Colors.white,),
                     RaisedButton(onPressed: (){
                        _animateToIndex(i+1);
                        setState(() {
                          isDone = true;
                        });
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
                ),
                
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

  _animateToIndex(i) => _controller.animateTo(_height * i, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
}