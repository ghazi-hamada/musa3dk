class OrderUser {
  final String ctegory;
  final String note;
  final String location;
  final String date;
  final String time;

  OrderUser(
      {required this.ctegory,
      required this.note,
      required this.location,
      required this.date,
      required this.time});
  Map<String, dynamic> toJson() => {
        'category': ctegory,
        'note': note,
        'location': location,
        'date': date,
        'time': time,
      };
  static OrderUser fromJson(Map<String, dynamic> json) => OrderUser(
      ctegory: json['category'],
      note: json['note'],
      location: json['location'],
      date: json['date'],
      time: json['time']);
}
