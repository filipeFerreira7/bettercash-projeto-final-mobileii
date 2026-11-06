import 'json.dart';
import 'transaction_type.dart';

/// Sealed class hierarchy representing financial transactions in BetterCash.
sealed class Transaction {
  const Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.account,
    this.category,
    this.note,
  });

  factory Transaction.fromJson(Json json) {
    final typeName = json['type'] as String? ?? 'expense';
    final type = TransactionType.parse(typeName);

    final id = json['id'] as String? ?? '';
    final amount = (json['amount'] as num?)?.toDouble() ?? 0.0;
    final description = json['description'] as String? ?? '';
    final category = json['category'] as String?;
    final date = DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now();
    final note = json['note'] as String?;
    final account = json['account'] as String? ?? '';
    final toAccount = json['toAccount'] as String?;

    return switch (type) {
      TransactionType.income => Income(
          id: id,
          amount: amount,
          description: description,
          category: category ?? 'Geral',
          date: date,
          account: account,
          note: note,
        ),
      TransactionType.expense => Expense(
          id: id,
          amount: amount,
          description: description,
          category: category ?? 'Outros',
          date: date,
          account: account,
          note: note,
        ),
      TransactionType.transfer => Transfer(
          id: id,
          amount: amount,
          description: description,
          date: date,
          account: account,
          toAccount: toAccount ?? '',
          category: category,
          note: note,
        ),
    };
  }

  final String id;
  final double amount;
  final String description;
  final String? category;
  final DateTime date;
  final String? note;
  final String account;

  TransactionType get type;

  Transaction copyWith({
    String? id,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    String? note,
    String? account,
    String? toAccount,
  });

  Json toJson() => {
        'id': id,
        'type': type.wireName,
        'amount': amount,
        'description': description,
        'category': category,
        'date': date.toUtc().toIso8601String(),
        'note': note,
        'account': account,
        if (this is Transfer) 'toAccount': (this as Transfer).toAccount else 'toAccount': null,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount &&
          description == other.description &&
          category == other.category &&
          date == other.date &&
          note == other.note &&
          account == other.account;

  @override
  int get hashCode => Object.hash(id, amount, description, category, date, note, account);
}

class Income extends Transaction {
  const Income({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.account,
    super.category,
    super.note,
  });

  @override
  TransactionType get type => TransactionType.income;

  @override
  Income copyWith({
    String? id,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    String? note,
    String? account,
    String? toAccount,
  }) {
    return Income(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      account: account ?? this.account,
      note: note ?? this.note,
    );
  }
}

class Expense extends Transaction {
  const Expense({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.account,
    super.category,
    super.note,
  });

  @override
  TransactionType get type => TransactionType.expense;

  @override
  Expense copyWith({
    String? id,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    String? note,
    String? account,
    String? toAccount,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      account: account ?? this.account,
      note: note ?? this.note,
    );
  }
}

class Transfer extends Transaction {
  const Transfer({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.account,
    required this.toAccount,
    super.category,
    super.note,
  });

  final String toAccount;

  @override
  TransactionType get type => TransactionType.transfer;

  @override
  Transfer copyWith({
    String? id,
    double? amount,
    String? description,
    String? category,
    DateTime? date,
    String? note,
    String? account,
    String? toAccount,
  }) {
    return Transfer(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      account: account ?? this.account,
      toAccount: toAccount ?? this.toAccount,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) =>
      super == other && other is Transfer && toAccount == other.toAccount;

  @override
  int get hashCode => Object.hash(super.hashCode, toAccount);
}
