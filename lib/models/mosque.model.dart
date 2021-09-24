class Mosque {
  String id;
  String mosqueName;
  String mosqueState;
  String mosqueLCDA;
  String mosqueAddress;
  String mosqueImamName;
  String mosqueMuadhin;
  String userId;
  String mosqueSize;
  String mosqueType;
  String mosqueLat;
  String mosqueLng;
  String mosqueImage;
  String mosqueContact;
  String mosqueContactOwner;
  String mosqueCreatedAt;

  Mosque({
    this.mosqueAddress, this.mosqueContact, this.mosqueContactOwner, this.mosqueCreatedAt, this.mosqueImage,
    this.mosqueImamName, this.mosqueLCDA, this.mosqueLat, this.mosqueLng, this.mosqueMuadhin, this.mosqueName,
    this.mosqueSize, this.mosqueState, this.mosqueType, this.userId, this.id
  });

  factory Mosque.fromJson(Map json) {
    return Mosque(
      mosqueAddress: json['mosque_address'] ?? '',
      id: json['id'] ?? '',
      mosqueContact: json['mosque_phone'] ?? '',
      mosqueContactOwner: json['contact_collected'] ?? '',
      mosqueCreatedAt: json['created_at'] ?? '',
      mosqueImage: json['image_url'] ?? '',
      mosqueImamName: json['mosque_imam_name'] ?? '',
      mosqueLCDA: json['local_id'] ?? '',
      mosqueLat: json['lat'] ?? '',
      mosqueLng: json['lng'] ?? '',
      mosqueMuadhin: json['mosque_muadhin_name'] ?? '', 
      mosqueName: json['mosque_name'] ?? '',
      mosqueSize: json['mosque_size'] ?? '',
      mosqueType: json['mosque_type'] ?? '',
      mosqueState: json['state_id'] ?? '',
      userId: json['user_id'] ?? '',
    );
  }
}