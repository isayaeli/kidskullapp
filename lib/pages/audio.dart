import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  final audioUrl;
  Audio({this.audioUrl});

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {

   AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Audio play')
      ),
      body: Container(
        child:Center(
          child:Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              IconButton(icon: Icon(Icons.play_arrow),
        onPressed: () async {
         await audioPlayer.play(widget.audioUrl);
        },
        )
            ]
          )
        )
      ),
    );
  }
}