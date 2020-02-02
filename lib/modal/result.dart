class Result {
  bool success;
  String qrImage;
  String dirName;

  Result({this.success, this.qrImage, this.dirName});

  Result.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    qrImage = json['qrImage'];
    dirName = json['dirName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['qrImage'] = this.qrImage;
    data['dirName'] = this.dirName;
    return data;
  }
}
