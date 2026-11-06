import 'json.dart';

/// Paginated list response wrapper.
class Page<T> {
  const Page({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.total,
  });

  factory Page.fromJson(
    Json json,
    T Function(Json json) fromItem,
  ) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return Page<T>(
      items: rawItems.whereType<Json>().map(fromItem).toList(),
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 20,
      total: json['total'] as int? ?? 0,
    );
  }

  final List<T> items;
  final int page;
  final int pageSize;
  final int total;

  bool get hasMore => page * pageSize < total;

  Json toJson(Json Function(T item) toItem) => {
        'items': items.map(toItem).toList(),
        'page': page,
        'pageSize': pageSize,
        'total': total,
      };
}
