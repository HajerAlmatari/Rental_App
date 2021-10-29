class User{
  int? userId;
  String? userName;
  String? userPassword;
  String? userAddressDescribtion;
  String? userEmail;
  String? userPhoneNumber;
  String? userImage;

  User({this.userId,this.userName,this.userPassword, this.userAddressDescribtion, this.userEmail,this.userPhoneNumber,this.userImage});

  Map<String,dynamic> toMap(){
    return {
      'userId': this.userId,
      'userName': this.userName,
      'userPassword':this.userPassword,
      'userAddressDescribtion': this.userAddressDescribtion,
      'userEmail': this.userEmail,
      'userPhoneNumber': this.userPhoneNumber,
      'userImage': this.userImage,
    };
  }

  User.fromMap(Map map){
    this.userId = map['userId'];
    this.userName = map['userName'];
    this.userPassword = map['userPassword'];
    this.userAddressDescribtion = map['userAddressDescribtion'];
    this.userEmail = map['userEmail'];
    this.userPhoneNumber = map['userPhoneNumber'];
    this.userImage = map['userImage'];
    
  }

 
}