class EmployeeModel {
  EmployeeModel({
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.department,
    required this.birthday,
    required this.country,
    required this.id,
  });

  DateTime createdAt;
  String name;
  String avatar;
  String email;
  String phone;
  List<String> department;
  DateTime birthday;
  String country;
  String id;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        email: json["email"],
        phone: json["phone"],
        department: List<String>.from(json["department"].map((x) => x)),
        birthday: DateTime.parse(json["birthday"]),
        country: json["country"],
        id: json["id"],
      );
}
