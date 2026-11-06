import 'transaction_type.dart';

/// Filter query parameters for transactions endpoint.
class TransactionFilter {
  const TransactionFilter({
    this.month,
    this.type,
    this.query,
    this.page = 1,
    this.pageSize = 20,
  });

  final String? month; // Format "YYYY-MM"
  final TransactionType? type;
  final String? query;
  final int page;
  final int pageSize;

  Map<String, String> toQueryParameters() => {
        if (month != null && month!.isNotEmpty) 'month': month!,
        if (type != null) 'type': type!.wireName,
        if (query != null && query!.isNotEmpty) 'q': query!,
        'page': '$page',
        'pageSize': '$pageSize',
      };

  TransactionFilter copyWith({
    String? month,
    TransactionType? type,
    String? query,
    int? page,
    int? pageSize,
  }) {
    return TransactionFilter(
      month: month ?? this.month,
      type: type ?? this.type,
      query: query ?? this.query,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
