import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/videos.dart';
import 'package:video_player/video_player.dart';


class Player extends StatefulWidget {
  
final String videoUrl;
final String title;
final String desc;
Player({this.videoUrl, this.title, this.desc});


  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child:Container(
          height: MediaQuery.of(context).size.height,
         
      child:Column(
       mainAxisAlignment:MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.start,
       children:<Widget>[
          Items(
          videoPlayerController: VideoPlayerController.network(widget.videoUrl),
                   looping: false,
                   allowFullScreen: true,
                   autoInitialize: true,
       ),
       Expanded(
         child:Container(
          color: Colors.white,
         height: MediaQuery.of(context).size.height,
         child: ListView(
           children:<Widget>[
             Padding(
               padding:EdgeInsets.only(left:20),
               child: Text(widget.title,
                style: TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
               ),
             ),
             Padding(
               padding:EdgeInsets.only(left:20, top: 20),
               child: Text(widget.desc,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
               ),
             )
           ]
         ),
       )
       ),
       
       ]
      )
    )
    );
  }
}