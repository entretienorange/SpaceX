class Mission {
  final String missionName;
  final String missionId;
  final String description;

  Mission({
    required this.missionName,
    required this.missionId,
    required this.description,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionName: json['mission_name'],
      missionId: json['mission_id'],
      description: json['description'],
    );
  }
}
