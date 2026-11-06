/// Type of financial transaction in BetterCash contract.
enum TransactionType {
  income('income'),
  expense('expense'),
  transfer('transfer');

  const TransactionType(this.wireName);

  final String wireName;

  static TransactionType parse(String value) {
    return switch (value.toLowerCase()) {
      'income' => TransactionType.income,
      'expense' => TransactionType.expense,
      'transfer' => TransactionType.transfer,
      _ => TransactionType.expense,
    };
  }
}
