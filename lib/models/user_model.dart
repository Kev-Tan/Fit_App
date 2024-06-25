import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String? profileImageUrl;
  final String email;
  final String gender;
  final int age;
  final int height;
  final int weight;
  final int neck;
  final int waist;
  final int hips;
  final String goal;
  final String level;
  final String frequency;
  final String duration;
  //final String time;
  final List<String>? favorites; // New field
  final List<Timestamp>? completedDays;

  UserModel({
    required this.uid,
    required this.username,
    this.profileImageUrl,
    required this.email,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.neck,
    required this.waist,
    required this.hips,
    required this.goal,
    required this.level,
    required this.frequency,
    required this.duration,
    //required this.time,
    this.favorites, // Make favorites nullable here
    this.completedDays,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      username: map['username'],
      profileImageUrl: map['profileImageUrl'],
      email: map['email'],
      gender: map['gender'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      neck: map['neck'],
      waist: map['waist'],
      hips: map['hips'],
      goal: map['goal'],
      level: map['level'],
      frequency: map['frequency'],
      duration: map['duration'],
      //time: map['time'],
      favorites: List<String>.from(map['favorites'] ?? []), // Parse favorites
      completedDays: (map['completedDays'] as List<dynamic>?)
          ?.map((timestamp) => timestamp as Timestamp)
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'neck': neck,
      'waist': waist,
      'hips': hips,
      'goal': goal,
      'level': level,
      'frequency': frequency,
      'duration': duration,
      //'time': time,
      'favorites': favorites, // Include favorites
      'completedDays': completedDays,
    };
  }
}
