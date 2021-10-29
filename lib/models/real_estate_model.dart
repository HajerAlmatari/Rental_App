class Real_Estate {
  
  int? realEstateId;
  String? realEstateDesciption;
  String? type;
  String? age;
  String? city;
  String? street;
  String? addressDescribtion;
  String? monthlyRent;
  String? firstPayment;
  String? numberOfRooms;
  String? numberOfFloors;
  String? furnisher;
  int? userId;

  Real_Estate({this.realEstateId,this.realEstateDesciption, this.type,this.age, this.city,this.street,this.addressDescribtion,this.monthlyRent,this. firstPayment,this. numberOfRooms,this. numberOfFloors,this. furnisher,this. userId});
 


  Map<String, dynamic> toMap() {
    return {
      'realEstateId': this.realEstateId,
      'realEstateDesciption':this.realEstateId,
      'type': this. type,
      'age':this.age,
      'city': this. city,
      'street': this. street,
      'addressDescribtion': this. addressDescribtion,
      'monthlyRent': this. monthlyRent,
      'firstPayment': this. firstPayment,
      'numberOfRooms': this. numberOfRooms,
      'numberOfFloors': this. numberOfFloors,
      'furnisher': this. furnisher,
      'userId': this. userId,
      
    };
  }
}


