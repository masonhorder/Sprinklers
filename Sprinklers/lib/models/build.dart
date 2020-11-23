class Builds {
  int designDate;
  int zones;
  String description;
  int buildId;

  Builds();

  Builds.fromMap(Map<String, dynamic> data) {
    // id = data['id'];
    designDate = data['designDate'];
    zones = data['zones'];
    description = data['description'];
    buildId = data['buildId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'designDate': designDate,
      'zones': zones,
      'description': description,
      'buildId': buildId,

    };
  }
}