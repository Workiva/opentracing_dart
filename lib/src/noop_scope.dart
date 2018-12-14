import 'package:opentracing/opentracing.dart';

/// The No-op implementation of [Scope] in which all operations are no-op
class NoopScope implements Scope {
  static Span _span = new NoopSpan();

  @override
  void close() {}

  @override
  Span get span => _span;
}
