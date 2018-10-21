import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of [Scope] in which all operations are no-op
class NoOpScope implements Scope {
  /// Returns a NoopScope.
  NoOpScope() {
    _span ??= new NoopSpan();
  }

  static Span _span;

  @override
  void close() {}

  @override
  Span get span => _span;
}
