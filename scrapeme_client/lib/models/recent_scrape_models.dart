class RecentScrapeModel {
  final String title;
  final DateTime timestamp;
  final String id;
  const RecentScrapeModel({required this.title, required this.timestamp, required this.id});

  factory RecentScrapeModel.fromJson(Map<String, dynamic> json) {
    return RecentScrapeModel(
      title: json['title'],
      timestamp: DateTime.parse(json['timestamp']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'timestamp': timestamp.toIso8601String(),
      'id': id,
    };
  }
}
