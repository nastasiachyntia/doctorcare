class EditPatientRequest {
  String? name;
  String? gender;
  String? birthDate;
  String? birthPlace;
  int? isMarriage;
  String? address;
  String? bloodType;
  int? weight;
  int? height;

  EditPatientRequest(
      {
        this.name,
        this.gender,
        this.birthDate,
        this.birthPlace,
        this.isMarriage,
        this.address,
        this.bloodType,
        this.weight,
        this.height});

  EditPatientRequest.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'EditPatientRequest{name: $name, gender: $gender, birthDate: $birthDate, birthPlace: $birthPlace, isMarriage: $isMarriage, address: $address, bloodType: $bloodType, weight: $weight, height: $height}';
  }
}
