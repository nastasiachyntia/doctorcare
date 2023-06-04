class DetailDoctorResponse {
  String? status;
  String? message;
  Data? data;

  DetailDoctorResponse({this.status, this.message, this.data});

  DetailDoctorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? code;
  String? name;
  String? email;
  String? description;
  String? image;
  int? experience;
  String? studyAt;
  String? createdAt;
  String? updatedAt;
  Specialists? specialists;

  Data(
      {this.id,
        this.code,
        this.name,
        this.email,
        this.description,
        this.image,
        this.experience,
        this.studyAt,
        this.createdAt,
        this.updatedAt,
        this.specialists});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    description = json['description'];
    image = json['image'];
    experience = json['experience'];
    studyAt = json['study_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    specialists = json['specialists'] != null
        ? new Specialists.fromJson(json['specialists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['description'] = this.description;
    data['image'] = this.image;
    data['experience'] = this.experience;
    data['study_at'] = this.studyAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.specialists != null) {
      data['specialists'] = this.specialists!.toJson();
    }
    return data;
  }
}

class Specialists {
  int? id;
  String? code;
  String? name;
  String? description;
  String? amount;

  Specialists({this.id, this.code, this.name, this.description, this.amount});

  Specialists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}
