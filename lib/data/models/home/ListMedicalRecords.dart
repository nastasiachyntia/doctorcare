class ListMedicalRecord {
  String? status;
  String? message;
  Data? data;

  ListMedicalRecord({this.status, this.message, this.data});

  ListMedicalRecord.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  List<MedicalRecords>? medicalRecords;

  Data({this.user, this.medicalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['medical_records'] != null) {
      medicalRecords = <MedicalRecords>[];
      json['medical_records'].forEach((v) {
        medicalRecords?.add(new MedicalRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final user = this.user;
    if (user != null) {
      data['user'] = user.toJson();
    }
    final medicalRecords = this.medicalRecords;
    if (medicalRecords != null) {
      data['medical_records'] =
          medicalRecords.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? code;
  String? name;
  String? email;
  String? gender;

  User({this.id, this.code, this.name, this.email, this.gender});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    return data;
  }
}

class MedicalRecords {
  String? id;
  String? patientCode;
  String? doctorCode;
  String? diagnosis;
  String? date;
  String? createdAt;
  String? updatedAt;

  MedicalRecords(
      {this.id,
        this.patientCode,
        this.doctorCode,
        this.diagnosis,
        this.date,
        this.createdAt,
        this.updatedAt});

  MedicalRecords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientCode = json['patient_code'];
    doctorCode = json['doctor_code'];
    diagnosis = json['diagnosis'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_code'] = this.patientCode;
    data['doctor_code'] = this.doctorCode;
    data['diagnosis'] = this.diagnosis;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
