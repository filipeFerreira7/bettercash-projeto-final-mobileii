import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';

import '../main.dart';

/// Interactive prototype screen demonstrating ALL components of the BetterCash Design System
/// (both pre-existing and newly extended components based on Design System v1.1 specs).
class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  String _selectedMonth = 'SET';
  String _selectedSegment = 'Todos';
  double _lastSelectedQuickValue = 0.0;
  bool _isLoadingButton = false;

  final _months = const ['JUL', 'AGO', 'SET', 'OUT', 'NOV'];
  final _segments = const ['Todos', 'Receita', 'Despesa', 'Transf.'];

  void _onQuickValue(double value) {
    setState(() => _lastSelectedQuickValue = value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Valor rápido selecionado: + R\$ ${value.toStringAsFixed(2)}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _simulateLoading() async {
    setState(() => _isLoadingButton = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoadingButton = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      padded: false,
      body: Column(
        children: [
          // HeaderReturn (novo componente)
          HeaderReturn(
            title: 'Design System — Protótipo',
            onBack: () => Navigator.maybePop(context),
            onClose: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
              children: [
                const Gap.sm(),
                // 1. BRANDING & BANNER
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BetterCashLogo(badgeText: 'Design System v1.1'),
                    ThemeModeButton(),
                  ],
                ),
                const Gap.md(),
                const AlertBanner(
                  message: 'Protótipo interativo exibindo componentes legados e novas extensões.',
                ),
                const Gap.lg(),

                // 2. NAVEGAÇÃO & SELEÇÃO DE MÊS (NOVOS COMPONENTES)
                const SectionHeader(title: '01. Navegação & Filtros de Mês'),
                MonthSelectorBar(
                  months: _months,
                  selectedMonth: _selectedMonth,
                  onMonthSelected: (m) => setState(() => _selectedMonth = m),
                  onPrevious: () {},
                  onNext: () {},
                ),
                const Gap.sm(),
                AppSegmentedControl<String>(
                  options: _segments,
                  selected: _selectedSegment,
                  onSelected: (s) => setState(() => _selectedSegment = s),
                ),
                const Gap.lg(),

                // 3. ADIÇÃO RÁPIDA & ENTRADAS DE FORMULÁRIO (NOVOS E EXISTENTES)
                const SectionHeader(title: '02. Adição Rápida & Campos de Entrada'),
                QuickValueSelector(
                  values: const [50.0, 100.0, 500.0],
                  onValueSelected: _onQuickValue,
                ),
                if (_lastSelectedQuickValue > 0) ...[
                  const Gap.xs(),
                  Text(
                    'Última adição: + R\$ ${_lastSelectedQuickValue.toStringAsFixed(2)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const Gap.md(),
                const AppTextField(
                  label: 'Descrição do lançamento',
                  hint: 'ex.: Mercado Pão de Açúcar',
                  prefixIcon: Icons.edit_note_rounded,
                ),
                const Gap.md(),
                const PasswordField(
                  label: 'Senha de confirmação',
                  showStrength: true,
                ),
                const Gap.lg(),

                // 4. CARTÕES DE SALDO E ESTATÍSTICAS (EXISTENTES)
                const SectionHeader(title: '03. Cartões & Resumo Financeiro'),
                BalanceCard(
                  balance: 'R\$ 4.286,41',
                  income: 'R\$ 9.526,55',
                  expense: 'R\$ 5.240,14',
                  monthLabel: 'Setembro 2026',
                ),
                const Gap.sm(),
                const CategoryBar(
                  label: 'Moradia',
                  amount: 'R\$ 3.027,16',
                  share: 0.58,
                ),
                const CategoryBar(
                  label: 'Alimentação',
                  amount: 'R\$ 1.840,20',
                  share: 0.35,
                ),
                const CategoryBar(
                  label: 'Lazer',
                  amount: 'R\$ 21,90',
                  share: 0.07,
                ),
                const Gap.lg(),

                // 5. LISTAS E TRANSAÇÕES (NOVOS E EXISTENTES)
                const SectionHeader(title: '04. Lançamentos & Linhas de Preferência'),
                const DateHeader('DOMINGO, 27 DE SETEMBRO'),
                TransactionTile(
                  kind: TransactionKind.expense,
                  title: 'Mercado Pão de Açúcar',
                  subtitle: 'Alimentação · Nubank',
                  amount: 'R\$ 306,70',
                  onTap: () {},
                ),
                TransactionTile(
                  kind: TransactionKind.income,
                  title: 'Salário Acme Tecnologia',
                  subtitle: 'Salário · Itaú',
                  amount: 'R\$ 8.500,00',
                  onTap: () {},
                ),
                TransactionTile(
                  kind: TransactionKind.transfer,
                  title: 'Entre minhas contas',
                  subtitle: 'Nubank → Itaú',
                  amount: 'R\$ 300,00',
                  onTap: () {},
                ),
                const Gap.sm(),
                PreferenceTile(
                  title: 'Privacidade e segurança',
                  subtitle: 'Cuide dos seus dados e permissões',
                  icon: Icons.shield_outlined,
                  onTap: () {},
                ),
                const Gap.lg(),

                // 6. FAMÍLIA DE FEEDBACK (NOVO COMPONENTE)
                const SectionHeader(title: '05. Família de Feedback & Mensagens'),
                const FeedbackCard.success(
                  title: 'Transação salva',
                  description: 'Mercado Pão de Açúcar - R\$ 306,70 registrado na conta Nubank.',
                ),
                const Gap.md(),
                FeedbackCard.error(
                  title: 'Não foi possível sincronizar',
                  description: 'Sua transação está salva neste aparelho. Verifique sua conexão.',
                  onAction: () {},
                ),
                const Gap.md(),
                const FeedbackCard.warning(
                  title: 'Atenção ao saldo disponível!',
                  description: 'Após esta despesa, o saldo estimado é R\$ 386,60.',
                ),
                const Gap.md(),
                const FeedbackCard.info(
                  title: 'Transferências entre contas',
                  description: 'Transferências movimentam seu dinheiro e não alteram seu saldo líquido.',
                ),
                const Gap.md(),
                FeedbackCard.empty(
                  title: 'VAZIO · BUSCA POR "VIAGEM"',
                  subtitle: 'Nada por aqui ainda',
                  description: 'Não encontramos transações com esse nome.',
                  onAction: () {},
                ),
                const Gap.md(),
                const FeedbackCard.loading(
                  title: 'Atualizando seu extrato...',
                  description: 'Buscando os lançamentos mais recentes.',
                ),
                const Gap.lg(),

                // 7. BOTÕES & AVATARES (EXISTENTES)
                const SectionHeader(title: '06. Botões e Avatares'),
                AppButton(
                  label: _isLoadingButton ? 'Processando...' : 'Salvar lançamento',
                  isLoading: _isLoadingButton,
                  onPressed: _simulateLoading,
                ),
                const Gap.sm(),
                AppButton.secondary(
                  label: 'Sair da conta',
                  onPressed: () {},
                ),
                const Gap.sm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton.text(
                      label: 'Cancelar',
                      onPressed: () {},
                    ),
                  ],
                ),
                const Gap.md(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppAvatar(name: 'Ana Ribeiro', size: 36),
                    Gap.md(),
                    AppAvatar(name: 'Bruno Souza', size: 48),
                    Gap.md(),
                    AppAvatar(name: 'Filipe Ferreira', size: 56),
                  ],
                ),
                const Gap.xxl(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
