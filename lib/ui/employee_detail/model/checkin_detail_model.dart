class CheckingDetailModel {
  CheckingDetailModel({
    required this.checkin,
    required this.location,
    required this.purpose,
    required this.id,
    required this.employeeId,
  });

  DateTime checkin;
  String location;
  String purpose;
  String id;
  String employeeId;

  factory CheckingDetailModel.fromJson(Map<String, dynamic> json) =>
      CheckingDetailModel(
        checkin: DateTime.parse(json["checkin"]),
        location: json["location"],
        purpose: json["purpose"],
        id: json["id"],
        employeeId: json["employeeId"],
      );
}
