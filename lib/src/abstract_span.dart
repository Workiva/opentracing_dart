// Copyright 2016 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:opentracing/opentracing.dart';
import 'dart:async';

/// [Span] represents a logical unit of work as part of a broader [Trace]. Examples
/// of [Span] might include remote procedure calls or a in-process function calls
/// to sub-components. A [Trace] has a single, top-level "root" [Span] that in turn
/// may have zero or more child [Span]s, which in turn may have children.
abstract class Span {
  /// Each span will have an associated SpanContext.
  SpanContext get context;

  /// Each span may or may not have an associated parentContext.
  SpanContext get parentContext;

  /// Each Span has an operation name, a human-readable string which concisely
  /// represents the work done by the Span (e.g., an RPC method name, a function
  /// name, or the name of a subtask or stage within a larger computation). The
  /// operation name should be the most general (i.e., least specific) string
  /// that identifies a (statistically) interesting class of Span instances;
  /// more specific sub-classes should be described using Tags.
  String get operationName;

  /// Each span has a UTC timestamp describing when it started.
  DateTime get startTime;

  /// Each span has a UTC timestamp describing when it started.
  set startTime(DateTime value);

  /// A Span may reference zero or more Spans that are causally related.
  /// OpenTracing presently defines two types of references: ChildOf and
  /// FollowsFrom. Both reference types specifically model direct causal
  /// relationships between a child Span and a parent Span.
  List<Reference> get references;

  /// Each span has a duration.
  Duration get duration;

  /// Each span has a UTC timestamp describing when it ended.
  DateTime get endTime;

  /// Every Span has zero or more Logs, each of which being a timestamped event
  /// name, optionally accompanied by a structured data payload of arbitrary
  /// size. The event name should be the stable identifier for some notable
  /// moment in the lifetime of a Span. For instance, a Span representing a
  /// browser page load might add an event for each field in Performance.timing.
  ///
  /// While it is not a formal requirement, specific event names should apply to
  /// many Span instances: tracing systems can use these event names (and
  /// timestamps) to analyze Spans in the aggregate.
  List<LogData> get logData;

  /// Every Span may also have zero or more key:value Tags, which do not have
  /// timestamps and simply annotate the spans.
  /// As is the case with Logs, if certain known tag key:values are used for
  /// common application scenarios, tracers can choose to pay special attention
  /// to them.
  Map<String, dynamic> get tags;

  /// Adds a single tag to the [Span].  See `addTags()` for details.
  /// Adds the given key value pairs to the set of [Span] tags.
  ///
  /// Multiple calls to addTags() results in the tags being the superset of
  /// all calls.
  ///
  /// The behavior of setting the same key multiple times on the same [Span]
  /// is undefined.
  ///
  /// The supported type of the values is implementation-dependent.
  /// Implementations are expected to safely handle all types of values but
  /// may choose to ignore unrecognized values (e.g. objects with cyclic
  /// references, function objects).
  void addTags(Map<String, dynamic> keyValuePairs);

  /// Sets the end timestamp and finalizes [Span] state.
  ///
  /// With the exception of calls to [Span].context() (which are always allowed),
  /// finish() must be the last call made to any [Span] instance, and to do
  /// otherwise leads to undefined behavior.
  /// Optional finish time in milliseconds as a Unix timestamp. Decimal
  /// values are supported for timestamps with sub-millisecond accuracy.
  /// If not specified, the current time (as defined by the
  /// implementation) will be used.
  void finish({DateTime finishTime});

  /// A hook for on finish event
  Future<Span> get whenFinished;

  /// Explicitly creates a log record associated with the [Span].
  void log(String event, {Object payload, DateTime timestamp});

  /// Tags this span with the current key-value pair.
  void setTag(String key, dynamic value);
}
