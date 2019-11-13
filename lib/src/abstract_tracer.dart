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

import 'dart:async';

import 'package:opentracing/opentracing.dart';
import 'package:opentracing/src/abstract_scope_manager.dart';

/// AbstractTracer provides the abstract definition for a Tracer and contains
/// some default method implementations.
abstract class AbstractTracer {
  /// Returns a new ChildOf reference.
  ///
  /// A Span may be the “ChildOf” a parent Span. In a “ChildOf” reference, the
  /// parent Span depends on the child Span in some capacity. All of the
  /// following would constitute ChildOf relationships:

  /// A Span representing the server side of an RPC may be the ChildOf a Span
  /// representing the client side of that RPC.
  /// A Span representing a SQL insert may be the ChildOf a Span representing an
  /// ORM save method.
  /// Many Spans doing concurrent (perhaps distributed) work may all
  /// individually be the ChildOf a single parent Span that merges the results
  /// for all children that return within a deadline.
  Reference childOf(SpanContext spanContext) {
    return Reference.childOf(spanContext);
  }

  /// Returns a SpanContext instance extracted from `carrier` in the given
  /// `format`.
  ///
  /// * Throws [SpanContextCorruptedError] if the [SpanContext] is missing
  /// fields or contains invalid values.
  ///
  /// OpenTracing defines a common set of `format` values (see
  /// formatTextMap, formatHttpHeaders, and formatBinary), and each has
  /// an expected carrier type.
  ///
  /// Consider this pseudo-code example:
  ///
  ///     // Use the inbound HTTP request's headers as a text map carrier.
  ///     var headersCarrier = inboundHttpReq.headers;
  ///     var wireCtx = Tracer.extract(Constants.formatHttpHeaders, headersCarrier);
  ///     var serverSpan = Tracer.startSpan('...', { childOf : wireCtx });
  SpanContext extract(String format, dynamic carrier);

  /// Returns the current [ScopeManager], which may be a noop but may not be
  /// null.
  ScopeManager get scopeManager;

  set scopeManager(ScopeManager value);

  /// Returns the activer [Span]. This is a shorthand for
  /// `Tracer.scopeManager().active().span()` and null will be returned if
  /// [ScopeManager].active()} is null.
  Span get activeSpan => scopeManager?.active?.span;

  /// Request that any buffered or in-memory data is flushed out of the process.
  /// Optionally a callback function with the signature `function(err)` will be
  /// called as soon as the flush completes. `err` should be null or
  /// undefined if the flush was successful.
  Future<dynamic> flush();

  /// Returns a new FollowsFrom reference.
  ///
  /// Some parent Spans do not depend in any way on the result of their child
  /// Spans. In these cases, we say merely that the child Span “FollowsFrom” the
  /// parent Span in a causal sense.
  Reference followsFrom(SpanContext spanContext) {
    return Reference.followsFrom(spanContext);
  }

  /// Injects the given SpanContext instance for cross-process propagation
  /// within `carrier`. The expected type of `carrier` depends on the value of
  /// `format.
  ///
  /// * Throws [InvalidCarrierFormatError] if the format is invalid or
  /// unsupported
  ///
  /// OpenTracing defines a common set of `format` values (see
  /// formatTextMap, formatHttpHeaders, and formatBinary), and each has
  /// an expected carrier type.
  void inject(SpanContext spanContext, String format, dynamic carrier);

  /// Starts and returns a new Span representing a logical unit of work.
  ///
  /// For example:
  ///
  ///     // Start a new (parentless) root Span:
  ///     Span parent = Tracer.startSpan(operationName: 'DoWork');
  ///
  ///     // Start a new (child) Span:
  ///     Span child = Tracer.startSpan(operationName: 'Subroutine', {
  ///         references: [Tracer.childOf(parent.context())],
  ///     });
  Span startSpan(String operationName,
      {SpanContext childOf,
      List<Reference> references,
      Map<String, dynamic> tags,
      DateTime startTime});
}
