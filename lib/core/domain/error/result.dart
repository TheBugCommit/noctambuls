import 'package:noctambuls/core/domain/error/failure.dart';

/// Represents the absence of a meaningful return value.
/// Use [Result<Unit>] for operations that succeed with no data.
final class Unit {
  const Unit();

  static const Unit instance = Unit();
}

/// A discriminated union that is either a successful [Ok] or an [Err].
///
/// Use [when] to handle both branches:
/// ```dart
/// final result = await someUseCase();
/// result.when(
///   success: (value) { /* handle success */ },
///   failure: (failure) { /* handle failure */ },
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Executes [success] if this is [Ok], or [failure] if this is [Err].
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  });

  bool get isOk => this is Ok<T>;

  bool get isErr => this is Err<T>;
}

/// Represents a successful result carrying [value].
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) => success(value);
}

/// Represents a failed result carrying a [failure].
final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) => failure(this.failure);
}
