import 'dart:convert';

import '../../models/ai_insight.dart';
import '../../models/json.dart';
import '../../models/transaction.dart';
import '../../models/user.dart';

/// Container for seed dataset loaded from seed.json or defaults.
class SeedData {
  const SeedData({
    required this.users,
    required this.transactions,
  });

  factory SeedData.fromJson(Json json) {
    final rawUsers = json['users'] as List<dynamic>? ?? [];
    final usersList = <User>[];
    final txsList = <Transaction>[];

    for (final rawUser in rawUsers.whereType<Json>()) {
      final u = User.fromJson(rawUser);
      usersList.add(u);

      final rawTxs = rawUser['transactions'] as List<dynamic>? ?? [];
      for (final rawTx in rawTxs.whereType<Json>()) {
        txsList.add(Transaction.fromJson(rawTx));
      }
    }

    return SeedData(
      users: usersList.isNotEmpty ? usersList : [SampleData.userAna, SampleData.userBruno],
      transactions: txsList.isNotEmpty ? txsList : SampleData.transactions(),
    );
  }

  factory SeedData.fromJsonString(String jsonContent) {
    final decoded = json.decode(jsonContent) as Map<String, dynamic>;
    return SeedData.fromJson(Map<String, Object?>.from(decoded));
  }

  final List<User> users;
  final List<Transaction> transactions;
}

/// Centralized realistic mock seed dataset for BetterCash.
abstract final class SampleData {
  static const defaultPassword = '123456';

  static final userAna = User(
    id: 'usr_01',
    name: 'Ana Ribeiro',
    email: 'ana@bettercash.dev',
    avatarUrl: null,
    createdAt: DateTime.utc(2024, 3, 11, 9),
  );

  static final userBruno = User(
    id: 'usr_02',
    name: 'Bruno Souza',
    email: 'bruno@bettercash.dev',
    avatarUrl: null,
    createdAt: DateTime.utc(2024, 5, 20, 14),
  );

  static List<Transaction> transactions() => [
        // September 2026 (2026-09)
        Income(
          id: 'tx_0001',
          amount: 8500.00,
          description: 'Salário Acme Tecnologia',
          category: 'Salário',
          date: DateTime.utc(2026, 9, 5, 9, 0),
          account: 'Itaú',
        ),
        Income(
          id: 'tx_0002',
          amount: 1026.55,
          description: 'Freela Design System',
          category: 'Outros',
          date: DateTime.utc(2026, 9, 15, 16, 30),
          account: 'Nubank',
          note: 'Projeto de extensão web',
        ),
        Expense(
          id: 'tx_0003',
          amount: 3027.16,
          description: 'Aluguel & Condomínio',
          category: 'Moradia',
          date: DateTime.utc(2026, 9, 1, 8, 0),
          account: 'Itaú',
          note: 'Vencimento dia 1º',
        ),
        Expense(
          id: 'tx_0004',
          amount: 306.70,
          description: 'Mercado Pão de Açúcar',
          category: 'Alimentação',
          date: DateTime.utc(2026, 9, 27, 14, 32),
          account: 'Nubank',
        ),
        Expense(
          id: 'tx_0005',
          amount: 1533.50,
          description: 'Supermercado do Mês',
          category: 'Alimentação',
          date: DateTime.utc(2026, 9, 10, 11, 15),
          account: 'Nubank',
        ),
        Expense(
          id: 'tx_0006',
          amount: 920.00,
          description: 'Combustível & Estacionamento',
          category: 'Transporte',
          date: DateTime.utc(2026, 9, 18, 19, 0),
          account: 'Itaú',
        ),
        Expense(
          id: 'tx_0007',
          amount: 260.00,
          description: 'Jantar & Cinema',
          category: 'Lazer',
          date: DateTime.utc(2026, 9, 22, 21, 30),
          account: 'Nubank',
        ),
        Expense(
          id: 'tx_0008',
          amount: 282.68,
          description: 'Farmácia & Saúde',
          category: 'Saúde',
          date: DateTime.utc(2026, 9, 25, 10, 0),
          account: 'Itaú',
        ),
        Transfer(
          id: 'tx_0009',
          amount: 300.00,
          description: 'Reserva de Emergência',
          date: DateTime.utc(2026, 9, 6, 10, 0),
          account: 'Nubank',
          toAccount: 'Itaú',
          note: 'Transferência para poupança',
        ),

        // August 2026 (2026-08)
        Income(
          id: 'tx_0010',
          amount: 8500.00,
          description: 'Salário Acme Tecnologia',
          category: 'Salário',
          date: DateTime.utc(2026, 8, 5, 9, 0),
          account: 'Itaú',
        ),
        Expense(
          id: 'tx_0011',
          amount: 3027.16,
          description: 'Aluguel & Condomínio',
          category: 'Moradia',
          date: DateTime.utc(2026, 8, 1, 8, 0),
          account: 'Itaú',
        ),
        Expense(
          id: 'tx_0012',
          amount: 1240.00,
          description: 'Compras Mês Carrefour',
          category: 'Alimentação',
          date: DateTime.utc(2026, 8, 12, 16, 0),
          account: 'Nubank',
        ),
        Expense(
          id: 'tx_0013',
          amount: 450.00,
          description: 'Revisão Carro',
          category: 'Transporte',
          date: DateTime.utc(2026, 8, 20, 11, 0),
          account: 'Itaú',
        ),
      ];

  static Map<String, AiInsight> sampleInsights() => {
        '2026-09': AiInsight(
          id: 'ins_001',
          month: '2026-09',
          generatedAt: DateTime.utc(2026, 9, 28, 10, 15),
          summary: 'Você gastou 18% a mais com Alimentação este mês.',
          recommendations: const [
            AiRecommendation(
              title: 'Reduza delivery',
              description: 'Substituir 4 deliveries por refeições caseiras pode economizar ~R\$ 320/mês.',
              potentialSaving: 320.00,
              priority: AiPriority.high,
            ),
            AiRecommendation(
              title: 'Otimize assinaturas de streaming',
              description: 'Você possui 3 serviços de streaming ativos. Considere pausar um serviço.',
              potentialSaving: 55.00,
              priority: AiPriority.medium,
            ),
          ],
          score: 72,
        ),
      };
}
