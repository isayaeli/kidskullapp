// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     // _controller = VideoPlayerController.asset('video/1.mp4');
//      _controller = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//     );
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//     _controller.setVolume(1.0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text('KidSkul')
//       ),
//       drawer: Drawer(),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot){
//           if( snapshot.connectionState == ConnectionState.done ){
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//                child:VideoPlayer(_controller),
//             );
//           }
//            else{
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//         }
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           setState(() {
//               if(_controller.value.isPlaying){
//                   _controller.pause();
//              }else{
//                  _controller.play();
//           }
//           });
//         },
//          child: Icon(_controller.value.isPlaying? Icons.pause : Icons.play_arrow ),
//         ),
//     );
//   }

// }



// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

// class Home extends StatefulWidget {
//   VideoPlayerController _controller;
//   bool looping;
  
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   ChewieController _chewieController;

//     @override
//   void initState() {
//     final _chewieController = ChewieController(
//       videoPlayerController: VideoPlayerController.asset('video/1.mp4'),
//       aspectRatio: 16 / 9,
//       autoPlay: true,
//       autoInitialize: true,
//       looping: true,
//     );
//     super.initState();
//   }


//   @override
//   void dispose() {
//     widget._controller.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Chewie(
//         controller:_chewieController
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:kidskulapp/pages/model.dart';
import 'package:kidskulapp/pages/video%20_screen.dart';
import 'package:http/http.dart' as http ;
import 'dart:async';
import 'dart:convert';

class Video extends StatefulWidget {
  
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
 
    Future<List<Videos>> _fetchData(http.Client client) async {
    var response =  await client.get('http://10.0.2.2:8000/api/videos');
    //  this line below check if statust code is not EQUAL to 404(404 is a statuscode for data not found )
    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((videos) => Videos.fromJson(videos)).toList();
    }else{
      throw Exception('Failed to get data');
    }
 
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('videos')
      ),


      body:Container(
        child: FutureBuilder(
          future: _fetchData(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot){
             if(snapshot.hasData && snapshot.connectionState == ConnectionState.done ){
              List<Videos> data = snapshot.data;
              return ListView.builder(
               itemCount:data.length,
               itemBuilder: (context, index){
                return InkWell(
                  onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Player(
                    videoUrl: data[index].video,
                    title: data[index].title,
                    desc: data[index].desc,
                  ))),
                  child: Hero(
                    tag: data[index].video,
                    child: Card(
                  elevation: 2.0,
                  margin: EdgeInsets.only(bottom: 10,left: 10),
                  child:Column(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children:<Widget>[
                     Container(
                       height: 200,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         image:DecorationImage(
                           image:NetworkImage(data[index].img),
                           fit: BoxFit.cover
                         )
                       ),
                     ),
                      SizedBox(width:50),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height:100,
                        child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                         CircleAvatar(
                           child:Icon(Icons.person)
                         ),
                       Expanded(
                         child:  Padding(
                          padding: EdgeInsets.only(top: 10, left: 15),
                          child:  Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                              Text(data[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize:15)
                          ),
                          // Text(data[index].desc,
                          // style: TextStyle(fontWeight: FontWeight.bold, fontSize:12)
                          // ),
                           Text('ummasoft . 1.2k views 1 day ago',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize:12, color: Colors.grey)
                          )
                           ],
                         ),
                        ),
                       ), 
                        Padding(
                          padding:EdgeInsets.only(left:90),
                          child:Icon(Icons.more_vert)
                        )
                        ]
                      )
                      ),
                    ]
                    
                  ),
                ),
                  )
                );

                //  return Items(
                //    videoPlayerController: VideoPlayerController.network(data[index].video),
                //    looping: false,
                //    allowFullScreen: true,
                //    autoInitialize: true,
                //  );
               },
              );
            }else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }return Center(
            child: CircularProgressIndicator(),
          );


          },
        )
      )
    );
  }
}