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

/// LogData is data associated with a [Span]. Every LogData instance should
/// specify at least one of Event and/or Payload.
class LogData {
  /// The timestamp of the log record; if set to the default value (the unix
  /// epoch), implementations should use Datetime.now().toUtc() implicitly.
  final DateTime timestamp;

  ///   event (if non-empty) should be the stable name of some notable moment in
  ///   the lifetime of a [Span]. For instance, a [Span] representing a browser page
  ///   load might add an Event for each of the Performance.timing moments
  ///   here: https://developer.mozilla.org/en-US/docs/Web/API/PerformanceTiming
  ///
  ///   While it is not a formal requirement, Event strings will be most useful
  ///   if they are *not* unique; rather, tracing systems should be able to use
  ///   them to understand how two similar [Span]s relate from an internal timing
  ///   perspective.
  final String event;

  /// payload is a free-form potentially structured object which [Tracer]
  /// implementations may retain and record all, none, or part of.
  ///
  /// If included, `payload` should be restricted to data derived from the
  /// instrumented application; in particular, it should not be used to pass
  /// semantic flags to a log() implementation.
  ///
  /// For example, an RPC system could log the wire contents in both
  /// directions, or a SQL library could log the query (with or without
  /// parameter bindings); tracing implementations may truncate or otherwise
  /// record only a snippet of these payloads (or may strip out PII, etc,
  /// etc).
  final dynamic payload;

  ///Returns a LogData instance.
  LogData(this.timestamp, this.event, this.payload);
}
