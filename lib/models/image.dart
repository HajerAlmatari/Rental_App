class Imagees{
  int? imgRealEstateId;
  String? realEstateImage;

  Imagees({this.imgRealEstateId,this.realEstateImage});

  


  Map<String, dynamic> toMap() {
    return {
      'imgRealEstateId': this.imgRealEstateId,
      'realEstateImage': this.realEstateImage,
      
      
    };
  }
}