class Videos {
  final video;
  final String img;
  final title;
  final desc;
 
  Videos({this.video,this.img, this.title, this.desc});

 factory Videos.fromJson(Map<String, dynamic> json){
   return Videos(
     video: json['video'],
     img: json['thumbnail'],
     title: json['title'],
     desc: json['desc']

   );

 }

}