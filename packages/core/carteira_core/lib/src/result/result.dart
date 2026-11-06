import 'app_error.dart';

/// Outcome of an operation that can succeed [Ok] or fail [Failure].
sealed class Result<T> {
  const Result();

  static Future<Result<T>> guard<T>(
    Future<T> Function() body, {
    AppError Function(Object error)? onError,
  }) async {
    try {
      return Ok(await body());
    } on AppException catch (e) {
      return Failure(e.error);
    } catch (e) {
      return Failure(onError?.call(e) ?? UnknownError(e));
    }
  }

  bool get isOk => this is Ok<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => switch (this) {
        Ok(:final value) => value,
        Failure() => null,
      };

  AppError? get errorOrNull => switch (this) {
        Ok() => null,
        Failure(:final error) => error,
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Ok(:final value) => Ok(transform(value)),
        Failure(:final error) => Failure(error),
      };

  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
        Ok(:final value) => transform(value),
        Failure(:final error) => Failure(error),
      };

  R when<R>({
    required R Function(T value) ok,
    required R Function(AppError error) failure,
  }) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Failure(:final error) => failure(error),
      };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;

  @override
  bool operator ==(Object other) => other is Ok<T> && other.value == value;

  @override
  int get hashCode => Object.hash(Ok, value);

  @override
  String toString() => 'Ok($value)';
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppError error;

  @override
  bool operator ==(Object other) => other is Failure<T> && other.error == error;

  @override
  int get hashCode => Object.hash(Failure, error);

  @override
  String toString() => 'Failure($error)';
}
