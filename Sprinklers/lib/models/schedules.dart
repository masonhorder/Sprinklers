class Schedules {
  // String id;
  String name;
  int deviceId;
  int createdAt;
  int updatedAt;

  Schedules();

  Schedules.fromMap(Map<String, dynamic> data) {
    // id = data['id'];
    name = data['name'];
    deviceId = data['deviceId'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'deviceId': deviceId,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}