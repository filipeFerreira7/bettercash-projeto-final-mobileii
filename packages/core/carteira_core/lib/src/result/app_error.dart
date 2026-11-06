/// Sealed hierarchy representing all domain and API error outcomes in Portuguese.
sealed class AppError {
  const AppError();

  String get message;

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType && other.toString() == toString();

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() => '$runtimeType($message)';
}

final class NetworkError extends AppError {
  const NetworkError();

  @override
  String get message => 'Sem conexão. Verifique sua internet e tente de novo.';
}

final class TimeoutError extends AppError {
  const TimeoutError();

  @override
  String get message => 'O servidor demorou demais para responder.';
}

final class UnauthorizedError extends AppError {
  const UnauthorizedError({
    this.expired = false,
    this.invalidCredentials = false,
  });

  final bool expired;
  final bool invalidCredentials;

  @override
  String get message {
    if (invalidCredentials) return 'E-mail ou senha incorretos.';
    if (expired) return 'Sua sessão expirou. Entre novamente.';
    return 'Você precisa entrar para continuar.';
  }

  @override
  String toString() =>
      'UnauthorizedError(expired: $expired, invalidCredentials: $invalidCredentials)';
}

final class NotFoundError extends AppError {
  const NotFoundError([this.resource]);

  final String? resource;

  @override
  String get message => resource == null
      ? 'Registro não encontrado.'
      : 'Registro não encontrado: $resource.';
}

final class ValidationError extends AppError {
  const ValidationError(this.fields, {this.detail});

  final Map<String, String> fields;
  final String? detail;

  @override
  String get message => detail ?? 'Alguns campos estão inválidos.';

  @override
  String toString() => 'ValidationError($fields)';
}

final class ServerError extends AppError {
  const ServerError(this.statusCode);

  final int statusCode;

  @override
  String get message => 'Erro no servidor ($statusCode). Tente mais tarde.';
}

final class UnknownError extends AppError {
  const UnknownError(this.cause);

  final Object cause;

  @override
  String get message => 'Algo deu errado. Tente novamente.';

  @override
  String toString() => 'UnknownError($cause)';
}

class AppException implements Exception {
  const AppException(this.error);

  final AppError error;

  @override
  String toString() => 'AppException($error)';
}
