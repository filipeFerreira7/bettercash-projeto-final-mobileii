import 'json.dart';

enum AiPriority {
  high('high'),
  medium('medium'),
  low('low');

  const AiPriority(this.wireName);
  final String wireName;

  static AiPriority parse(String val) {
    return switch (val.toLowerCase()) {
      'high' => AiPriority.high,
      'medium' => AiPriority.medium,
      _ => AiPriority.low,
    };
  }
}

class AiRecommendation {
  const AiRecommendation({
    required this.title,
    required this.description,
    required this.potentialSaving,
    required this.priority,
  });

  factory AiRecommendation.fromJson(Json json) {
    return AiRecommendation(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      potentialSaving: (json['potentialSaving'] as num?)?.toDouble() ?? 0.0,
      priority: AiPriority.parse(json['priority'] as String? ?? 'low'),
    );
  }

  final String title;
  final String description;
  final double potentialSaving;
  final AiPriority priority;

  Json toJson() => {
        'title': title,
        'description': description,
        'potentialSaving': potentialSaving,
        'priority': priority.wireName,
      };
}

class AiInsight {
  const AiInsight({
    required this.id,
    required this.month,
    required this.generatedAt,
    required this.summary,
    required this.recommendations,
    required this.score,
  });

  factory AiInsight.fromJson(Json json) {
    final rawRecs = json['recommendations'] as List<dynamic>? ?? [];
    return AiInsight(
      id: json['id'] as String? ?? '',
      month: json['month'] as String? ?? '',
      generatedAt: DateTime.tryParse(json['generatedAt'] as String? ?? '') ?? DateTime.now(),
      summary: json['summary'] as String? ?? '',
      recommendations: rawRecs.whereType<Json>().map(AiRecommendation.fromJson).toList(),
      score: json['score'] as int? ?? 0,
    );
  }

  final String id;
  final String month;
  final DateTime generatedAt;
  final String summary;
  final List<AiRecommendation> recommendations;
  final int score;

  Json toJson() => {
        'id': id,
        'month': month,
        'generatedAt': generatedAt.toUtc().toIso8601String(),
        'summary': summary,
        'recommendations': recommendations.map((r) => r.toJson()).toList(),
        'score': score,
      };
}
