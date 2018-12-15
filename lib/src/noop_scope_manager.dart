import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of a [NoopScopeManager] in which all operations are
/// no-ops.
class NoopScopeManager implements ScopeManager {
  static Scope _scope = new NoopScope();

  @override
  Scope activate(Span span, {bool finishSpanOnClose}) {
    return active;
  }

  @override
  Scope get active => _scope;
}
