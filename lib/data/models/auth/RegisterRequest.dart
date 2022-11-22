class RegisterRequest {
  String? email;
  String? password;
  String? name;
  String? gender;
  String? birthDate;
  String? birthPlace;
  int? isMarriage;
  String? address;
  String? bloodType;
  int? weight;
  int? height;

  RegisterRequest(
      {this.email,
      this.password,
      this.name,
      this.gender,
      this.birthDate,
      this.birthPlace,
      this.isMarriage,
      this.address,
      this.bloodType,
      this.weight,
      this.height});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    birthPlace = json['birth_place'];
    isMarriage = json['is_marriage'];
    address = json['address'];
    bloodType = json['blood_type'];
    weight = json['weight'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['birth_place'] = birthPlace;
    data['is_marriage'] = isMarriage;
    data['address'] = address;
    data['blood_type'] = bloodType;
    data['weight'] = weight;
    data['height'] = height;
    return data;
  }
}
