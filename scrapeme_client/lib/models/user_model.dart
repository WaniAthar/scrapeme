import 'package:hive_flutter/hive_flutter.dart';

class User {
  final String name, email, nickname;
  User({required this.name, required this.email, required this.nickname});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      nickname: map['nickname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'nickname': nickname,
    };
  }
}

// //adapter for hive box
// class UserAdapter extends TypeAdapter<User> {
//   @override
//   final typeId = 1;


//   @override
//   User read(BinaryReader reader) {
//     return User(
//       name: reader.readString(),
//       email: reader.readString(),
//       nickname: reader.readString(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, User obj) {
//     writer.writeString(obj.name);
//     writer.writeString(obj.email);
//     writer.writeString(obj.nickname);
//   }
// }
