class UserModel {
  final String userUID;

  UserModel({ required this.userUID });

  Map<String, dynamic> toMap(){
    return {
      'userUID': userUID
    };
  }
}
