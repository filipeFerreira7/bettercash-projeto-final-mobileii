import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BetterCashApp());
}

class BetterCashApp extends StatelessWidget {
  const BetterCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetterCash — Design System Showcase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const SampleShowcaseScreen(),
    );
  }
}

/// Screen demonstrating all Design System components (both existing & newly added extensions).
class SampleShowcaseScreen extends StatefulWidget {
  const SampleShowcaseScreen({super.key});

  @override
  State<SampleShowcaseScreen> createState() => _SampleShowcaseScreenState();
}

class _SampleShowcaseScreenState extends State<SampleShowcaseScreen> {
  String _selectedMonth = 'SET';
  String _selectedSegment = 'Todos';
  double _lastSelectedQuickValue = 0.0;
  bool _isLoading = false;

  final _months = const ['JUL', 'AGO', 'SET', 'OUT', 'NOV'];
  final _segments = const ['Todos', 'Receita', 'Despesa', 'Transf.'];

  void _onQuickValueSelected(double val) {
    setState(() => _lastSelectedQuickValue = val);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Valor rápido selecionado: + R\$ ${val.toStringAsFixed(2)}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      padded: false,
      body: Column(
        children: [
          // 1. HEADER WITH RETURN & CLOSE (NOVO COMPONENTE)
          HeaderReturn(
            title: 'BetterCash — Protótipo Design System',
            onBack: () {},
            onClose: () {},
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
              children: [
                const Gap.sm(),

                // BRANDING (NOVO COMPONENTE)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BetterCashLogo(badgeText: 'Design System v1.1'),
                    Text('Mobile & Web'),
                  ],
                ),
                const Gap.md(),

                // ALERT BANNER (NOVO COMPONENTE)
                const AlertBanner(
                  message: 'Protótipo oficial de validação dos componentes visuais do BetterCash.',
                ),
                const Gap.lg(),

                // 2. NAVEGAÇÃO DE MÊS & FILTRO SEGMENTADO (NOVOS COMPONENTES)
                const SectionHeader(title: 'Navegação & Filtros (Novos Componentes)'),
                MonthSelectorBar(
                  months: _months,
                  selectedMonth: _selectedMonth,
                  onMonthSelected: (month) => setState(() => _selectedMonth = month),
                  onPrevious: () {},
                  onNext: () {},
                ),
                const Gap.sm(),
                AppSegmentedControl<String>(
                  options: _segments,
                  selected: _selectedSegment,
                  onSelected: (seg) => setState(() => _selectedSegment = seg),
                ),
                const Gap.lg(),

                // 3. ADIÇÃO RÁPIDA & ENTRADAS DE DADOS
                const SectionHeader(title: 'Adição Rápida & Formulários'),
                QuickValueSelector(
                  values: const [50.0, 100.0, 500.0],
                  onValueSelected: _onQuickValueSelected,
                ),
                if (_lastSelectedQuickValue > 0) ...[
                  const Gap.xs(),
                  Text(
                    'Valor acumulado adicionado: + R\$ ${_lastSelectedQuickValue.toStringAsFixed(2)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Gap.md(),
                const AppTextField(
                  label: 'Descrição da transação',
                  hint: 'ex.: Mercado Pão de Açúcar',
                  prefixIcon: Icons.shopping_bag_outlined,
                ),
                const Gap.md(),
                const PasswordField(
                  label: 'Senha de segurança',
                  showStrength: true,
                ),
                const Gap.lg(),

                // 4. CARTÕES DE SALDO E ESTATÍSTICAS (COMPONENTES EXISTENTES)
                const SectionHeader(title: 'Cartões de Saldo & Categorias'),
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

                // 5. LISTA DE TRANSAÇÕES E CONFIGURAÇÕES (NOVOS E EXISTENTES)
                const SectionHeader(title: 'Lançamentos & Preferências'),
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

                // 6. FAMÍLIA DE FEEDBACK COMPLETA (NOVO COMPONENTE)
                const SectionHeader(title: 'Família de Feedback Completa'),
                const FeedbackCard.success(
                  title: 'Transação salva',
                  description: 'Mercado Pão de Açúcar - R\$ 306,70 registrada na conta Nubank.',
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
                  title: 'Transferências financeiras',
                  description: 'Movimentações entre contas próprias não afetam o resultado do mês.',
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

                // 7. BOTÕES E AVATARES
                const SectionHeader(title: 'Ações & Avatares'),
                AppButton(
                  label: _isLoading ? 'Salvando...' : 'Salvar lançamento',
                  isLoading: _isLoading,
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
