class Launch {
  final String id;
  final String name;
  final String date;
  final String details;

  Launch({
    required this.id,
    required this.name,
    required this.date,
    required this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      id: json['flight_number'].toString(),
      name: json['mission_name'] ?? 'mission err',  
      date: json['launch_date_utc'] ?? 'Date err',  
      details: json['details'] ?? 'details err',  
    );
  }
}
