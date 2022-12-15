class PatientUserProfileResponse {
  String? status;
  String? message;
  Data? data;

  PatientUserProfileResponse({this.status, this.message, this.data});

  PatientUserProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    final tempData = this.data;
    if (tempData != null) {
      data['data'] = tempData.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? code;
  String? name;
  String? email;
  String? image;
  String? gender;
  String? birthDate;
  String? birthPlace;
  int? isMarriage;
  String? address;
  String? bloodType;
  int? weight;
  int? height;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.image,
        this.gender,
        this.birthDate,
        this.birthPlace,
        this.isMarriage,
        this.address,
        this.bloodType,
        this.weight,
        this.height,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    birthPlace = json['birth_place'];
    isMarriage = json['is_marriage'];
    address = json['address'];
    bloodType = json['blood_type'];
    weight = json['weight'];
    height = json['height'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['birth_place'] = this.birthPlace;
    data['is_marriage'] = this.isMarriage;
    data['address'] = this.address;
    data['blood_type'] = this.bloodType;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
