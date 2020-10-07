import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Items extends StatefulWidget {
  
 final VideoPlayerController videoPlayerController;
 final bool looping;
 final bool allowFullScreen;
 final bool autoInitialize;
   Items({
       this.videoPlayerController,
       this.looping,
       this.allowFullScreen,
       this. autoInitialize,
     });
     
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
   ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
     _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: widget.autoInitialize,
      allowFullScreen: widget.allowFullScreen,
      looping: widget.looping,
      errorBuilder: (context, errorMessage){
        return Center(
          child: Text(errorMessage,
          style: TextStyle(color: Colors.white),),
        );
        
      },

    );
    
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Chewie(controller: _chewieController,),
      );
  }


  @override
  void dispose() {
     super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
   
  }

}