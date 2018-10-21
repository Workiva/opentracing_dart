import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of a [ScopeManager] in which all operations are
/// no-ops.
class NoOpScopeManager implements ScopeManager {
  /// Returns a NoOpScopeManager.
  NoOpScopeManager() {
    _scope ??= new NoOpScope();
  }
  static Scope _scope;

  @override
  Scope activate(Span span, {bool finishSpanOnClose}) {
    return active;
  }

  @override
  Scope get active => _scope;
}
