extension GroupByX<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E element) key) {
    final map = <K, List<E>>{};
    for (final element in this) {
      final k = key(element);
      map.putIfAbsent(k, () => []).add(element);
    }
    return map;
  }
}
