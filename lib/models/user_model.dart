class UserModel {
  String uid;
  String? username;
  String? email;
  String? gender;
  int? age;
  int? height;
  int? weight;
  int? neck;
  int? waist;
  int? hips;
  String? goal;
  String? level;
  String? frequency;
  String? duration;
  String? time;

  UserModel({
    required this.uid,
    this.username,
    this.email,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.neck,
    this.waist,
    this.hips,
    this.goal,
    this.level,
    this.frequency,
    this.duration,
    this.time,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      username: data['username'],
      email: data['email'],
      gender: data['gender'],
      age: data['age'],
      height: data['height'],
      weight: data['weight'],
      neck: data['neck'],
      waist: data['waist'],
      hips: data['hips'],
      goal: data['goal'],
      level: data['level'],
      frequency: data['frequency'],
      duration: data['duration'],
      time: data['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
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
      'time': time,
    };
  }
}
