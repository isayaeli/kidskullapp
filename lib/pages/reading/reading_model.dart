class VowelData {
  final vowel;
  final img;
  final audio;

  VowelData({this.vowel, this.img, this.audio});

  factory VowelData.fromJson(Map<String, dynamic>json){
    return VowelData(
      vowel: json['vowel'],
      img: json['image'],
      audio: json['audio']
    );
  }

}