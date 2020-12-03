class Devices {
  String name;
  int buildId;
  int deviceId;
  int manufacturedDate;
  List zones;


  Devices();

  Devices.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    deviceId = data['deviceId'];
    manufacturedDate = data['manufacturedDate'];
    buildId = data['buildId'];
    zones = data['zones'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'deviceId': deviceId,
      'manufacturedDate': manufacturedDate,
      'buildId': buildId,
      'zones': zones,
    };
  }
}