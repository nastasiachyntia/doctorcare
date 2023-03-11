class ListSpecialistResponse {
  String? status;
  String? message;
  List<Data>? data;

  ListSpecialistResponse({this.status, this.message, this.data});

  ListSpecialistResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Specialist{status: $status, message: $message, data: $data}';
  }
}

class Data {
  int? id;
  String? code;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, code: $code, name: $name, description: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
