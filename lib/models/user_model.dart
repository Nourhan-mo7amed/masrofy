class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoURL,
  });

  // 🟢 Factory constructor from Firestore Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'],
    );
  }

  // 🟢 عشان تقدر تبعت البيانات للفايرستور
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoURL': photoURL,
    };
  }
}
