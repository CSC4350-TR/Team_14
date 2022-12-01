import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordImages {
  PasswordImages(
      {required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.image6,
      required this.image7,
      required this.image8});
  factory PasswordImages.fromMap(Map data) {
    return PasswordImages(
        image1: data['image1'],
        image2: data['image2'],
        image3: data['image3'],
        image4: data['image4'],
        image5: data['image5'],
        image6: data['image6'],
        image7: data['image7'],
        image8: data['image8']);
  }
  Map toJson() => {
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'image5': image5,
        'image6': image6,
        'image8': image7,
        'image8': image8
      };
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
}
