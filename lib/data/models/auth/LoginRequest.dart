class LoginRequest {
  bool? isDoctor;
  String? email;
  String? password;

  LoginRequest({this.isDoctor, this.email, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    isDoctor = json['is_doctor'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_doctor'] = this.isDoctor;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
