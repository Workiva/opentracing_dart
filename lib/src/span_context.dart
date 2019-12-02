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

/// SpanContext represents Span state that must propagate to descendant Spans
/// and across process boundaries.
///
/// SpanContext is logically divided into two pieces: the user-level "Baggage"
/// (see setBaggageItem and getBaggageItem) that propagates across Span
/// boundaries and any Tracer-implementation-specific fields that are needed to
/// identify or otherwise contextualize the associated Span instance (e.g., a
/// <trace_id, span_id, sampled> tuple).
class SpanContext {
  /// Every SpanContext has an associated traceId.
  dynamic traceId;

  /// Every SpanContext has an associated spanId.
  dynamic spanId;

  /// A SpanContext may optionally indicate if they are sampled or not.
  bool sampled;

  /// A SpanContext may optionally include baggage.
  Map<dynamic, dynamic> _baggage = Map<dynamic, dynamic>();

  /// Returns a new SpanContext.
  SpanContext({this.traceId, this.spanId, this.sampled = false});

  /// ForeachBaggageItem grants access to all baggage items stored in the
  /// SpanContext.
  /// The handler function will be called for each baggage key/value pair.
  /// The ordering of items is not guaranteed.
  ///
  /// The bool return value indicates if the handler wants to continue iterating
  /// through the rest of the baggage items; for example if the handler is trying to
  /// find some baggage item by pattern matching the name, it can return false
  /// as soon as the item is found to stop further iterations.
  void forEachBaggageItem(Function baggageHandler) {
    bool continueIterations = true;
    for (dynamic key in this._baggage.keys) {
      continueIterations = baggageHandler(this._baggage[key]);
      if (!continueIterations) {
        return;
      }
    }
  }

  /// Returns the value for a baggage item given its key.
  dynamic getBaggageItem(dynamic key) {
    return _baggage[key];
  }

  /// Baggage is a set of key:value pairs stored in a Span (and its SpanContext)
  /// and propagated in-band to all child Spans and their SpanContexts: in this
  /// way, the “Baggage” travels with the trace, hence the name. Given a
  /// full-stack OpenTracing integration, Baggage enables powerful functionality
  /// by transparently propagating arbitrary application data: for example, an
  /// end-user id may be added as a Baggage item in a mobile app, propagate (via
  /// the distributed tracing machinery) into the depths of a storage system,
  /// and recovered at the bottom of the stack to identify a particularly
  /// expensive SQL query.
  Map<dynamic, dynamic> get baggage => _baggage;

  /// Sets a key:value pair on this SpanContext that also propagates to future
  /// children of the associated Span.
  ///
  /// setBaggageItem() enables powerful functionality given a full-stack
  /// opentracing integration (e.g., arbitrary application data from a web
  /// client can make it, transparently, all the way into the depths of a
  /// storage system), and with it some powerful costs: use this feature with
  /// care.
  ///
  /// IMPORTANT NOTE #1: setBaggageItem() will only propagate baggage items to
  /// *future* causal descendants of the associated Span.
  ///
  /// IMPORTANT NOTE #2: Use this thoughtfully and with care. Every key and
  /// value is copied into every local *and remote* child of the associated
  /// Span, and that can add up to a lot of network and cpu overhead.
  void setBaggageItem(String key, dynamic value) {
    _baggage[key] = value;
  }
}
