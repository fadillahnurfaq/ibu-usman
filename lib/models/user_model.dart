class UserModel {
  String? email;
  String? id;
  bool? isAdmin;
  String? name;
  String? phoneNumber;
  String? photo;
  dynamic point;

  UserModel(
      {this.email,
      this.id,
      this.isAdmin,
      this.name,
      this.phoneNumber,
      this.photo,
      this.point});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    id = json['id'] ?? "";
    isAdmin = json['is_admin'] ?? false;
    name = json['name'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    photo = json['photo'] ?? "";
    point = json['point'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email ?? "";
    data['id'] = id ?? "";
    data['is_admin'] = isAdmin ?? "";
    data['name'] = name ?? "";
    data['phone_number'] = phoneNumber ?? "";
    data['photo'] = phoneNumber ?? "";
    data['point'] = point ?? 0.0;
    return data;
  }
}
