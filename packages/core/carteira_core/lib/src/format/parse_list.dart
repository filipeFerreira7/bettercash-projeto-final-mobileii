import '../models/json.dart';

List<T> parseList<T>(dynamic jsonList, T Function(Json) fromJson) {
  if (jsonList is! List) return [];
  return jsonList.whereType<Json>().map(fromJson).toList();
}
