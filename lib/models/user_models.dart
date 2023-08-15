class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;

  UserModel(this.name, this.uid, this.profilePic, this.isOnline,
      this.phoneNumber, this.groupId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        map['name'] as String,
        map['uid'] as String,
        map['profilePic'] as String,
        map['isOnline'] as bool,
        map['phoneNumber'] as String,
        List<String>.from(
          (map['groupId'] as List<String>),
        ));
  }
}
