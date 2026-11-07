import 'package:carteira_core/carteira_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/viewmodel/base_view_model.dart';

/// ViewModel for the Home Scene managing financial summary, month selection,
/// balance visibility toggle and category breakdown.
class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required DashboardRepository dashboardRepository,
    required ValueNotifier<ThemeMode> themeNotifier,
    String initialMonth = '2026-09',
  })  : _dashboardRepository = dashboardRepository,
        _themeNotifier = themeNotifier,
        _selectedMonthKey = initialMonth {
    _themeNotifier.addListener(_onThemeChanged);
  }

  final DashboardRepository _dashboardRepository;
  final ValueNotifier<ThemeMode> _themeNotifier;

  String _selectedMonthKey;
  bool _isBalanceVisible = true;
  int _currentTabIndex = 0;
  Dashboard? _dashboard;

  final List<String> _months = const ['JUL', 'AGO', 'SET', 'OUT'];
  int _selectedMonthIndex = 2;

  // Getters
  String get selectedMonthKey => _selectedMonthKey;
  bool get isBalanceVisible => _isBalanceVisible;
  int get currentTabIndex => _currentTabIndex;
  Dashboard? get dashboard => _dashboard;
  List<String> get months => _months;
  int get selectedMonthIndex => _selectedMonthIndex;
  ValueNotifier<ThemeMode> get themeNotifier => _themeNotifier;

  bool get isDarkMode => _themeNotifier.value == ThemeMode.dark;

  String get monthLabel => switch (_selectedMonthKey) {
    '2026-07' => 'Julho de 2026',
    '2026-08' => 'Agosto de 2026',
    '2026-09' => 'Setembro de 2026',
    '2026-10' => 'Outubro de 2026',
    _ => 'Setembro de 2026',
  };

  /// Alterna entre tema claro e escuro.
  void toggleTheme() {
    _themeNotifier.value = _themeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void _onThemeChanged() => notifyListeners();

  @override
  void dispose() {
    _themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  /// Initializer called when view is mounted.
  Future<void> loadData() async {
    setLoading(true);
    clearError();

    final result = await _dashboardRepository.getDashboard(_selectedMonthKey);

    result.when(
      ok: (data) {
        _dashboard = data;
        setLoading(false);
      },
      failure: (error) {
        setError(error.message);
        setLoading(false);
      },
    );
  }

  /// Toggles visibility of balance figure (eye icon).
  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  /// Changes selected month chip.
  Future<void> selectMonthIndex(int index) async {
    if (index < 0 || index >= _months.length) return;
    _selectedMonthIndex = index;

    _selectedMonthKey = switch (index) {
      0 => '2026-07',
      1 => '2026-08',
      2 => '2026-09',
      3 => '2026-10',
      _ => '2026-09',
    };

    notifyListeners();
    await loadData();
  }

  /// Updates bottom navigation bar tab index.
  void setTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }
}
