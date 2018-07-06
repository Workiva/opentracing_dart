/// The following log fields are recommended for instrumentors who are trying to capture more
/// information about a logged event. Tracers may expose additional features based on these
/// standardized data points.

/// @see <a href="https://github.com/opentracing/specification/blob/master/semantic_conventions.md">https://github.com/opentracing/specification/blob/master/semantic_conventions.md</a>

class LogField {
  /// The type or "kind" of an error (only for event="error" logs). E.g., "Exception", "OSError"
  static const String errorKind = "error.kind";

  /// The actual Throwable/Exception/Error object instance itself. E.g., A java.lang.UnsupportedOperationException instance
  static const String errorObject = "error.object";

  /// A stable identifier for some notable moment in the lifetime of a Span. For instance, a mutex
  /// lock acquisition or release or the sorts of lifetime events in a browser page load described
  /// in the Performance.timing specification. E.g., from Zipkin, "cs", "sr", "ss", or "cr". Or,
  /// more generally, "initialized" or "timed out". For errors, "error"
  static const String event = "event";

  /// A concise, human-readable, one-line message explaining the event. E.g., "Could not connect
  /// to backend", "Cache invalidation succeeded"
  static const String message = "message";

  /// A stack trace in platform-conventional format; may or may not pertain to an error.
  static const String stack = "stack";
}
