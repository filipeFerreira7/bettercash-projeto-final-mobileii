enum Currency {
  brl('R\$', 'BRL'),
  usd('US\$', 'USD'),
  eur('€', 'EUR');

  const Currency(this.symbol, this.code);

  final String symbol;
  final String code;
}
