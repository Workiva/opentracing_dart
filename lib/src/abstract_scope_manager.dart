import 'package:opentracing/opentracing.dart';

/// The [ScopeManager] abstracts both the activation of [Span] instances via
/// [ScopeManager].activate(Span, boolean)} and access to an active
/// [Span]/[Scope] via [ScopeManager].active.
abstract class ScopeManager {
  /// Make a Span instance active.
  ///
  /// [span] that should become the [active] [Span]
  /// When [finishSpanOnClose] is true, the [span] will automatically be
  /// finished when [Scope].close() is called.
  /// Returns a [Scope] instance to control the end of the active period for the
  /// [Span]. It is a programming error to neglect calling [Scope].close() on
  /// the returned instance.
  Scope activate(Span span, {bool finishSpanOnClose});

  /// Return the currently active [Scope] which can be used to access the
  /// currently active [Scope].span.
  /// If there is a [Scope] non-null scope, its wrapped [Span] becomes an
  /// implicit parent(as [referenceChildOf]) of any newly-created
  /// [Span] at [AbstractTracer].startSpan.
  ///
  /// Returns the [Scope], or null if none could be found.
  Scope get active;
}
