import 'package:opentracing/opentracing.dart';

/// A [Scope] formalizes the activation and deactivation of a [Span], usually
/// from a CPU standpoint.
///
/// Many times a [Span] will be extant ([Span].finish() has not been called)
/// despite being in a non-runnable state from a CPU/scheduler standpoint. For
/// instance, a [Span] representing the client side of an RPC will be unfinished
/// but blocked on IO while the RPC is still outstanding. A [Scope] defines when
/// a given [Span] is scheduled and on the path.
abstract class Scope {
  /// Mark the end of the active period for the current thread and [Scope],
  /// updating the [ScopeManager].active() in the process.
  ///
  /// NOTE: Calling 'close' more than once on a single {@link Scope} instance
  /// leads to undefined behavior.
  void close();

  /// Returns the [Span] that's been scoped by this [Scope]
  Span get span;
}
