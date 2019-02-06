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

import 'package:meta/meta.dart';
import 'package:opentracing/opentracing.dart';

/// The ScopeManager abstracts both the activation of [Span] instances via
/// ScopeManager.activate(Span, boolean)} and access to an active
/// [Span]/[Scope] via ScopeManager.active.
abstract class ScopeManager {
  /// Make a Span instance active.
  ///
  /// Span that should become the active Span
  /// When [finishSpanOnClose] is true, the [span] will automatically be
  /// finished when Scope.close() is called.
  /// Returns a Scope instance to control the end of the active period for the
  /// [Span]. It is a programming error to neglect calling Scope.close() on
  /// the returned instance.
  Scope activate(Span span, bool finishSpanOnClose);

  /// Return the currently active [Scope] which can be used to access the
  /// currently active [Scope].span.
  /// If there is a [Scope] non-null scope, its wrapped [Span] becomes an
  /// implicit parent(as [referenceChildOf]) of any newly-created
  /// [Span] at [AbstractTracer].startSpan.
  ///
  /// Returns the [Scope], or null if none could be found.
  Scope get active;

  /// DO NOT USE THIS! This is only to be used by Scope OR ScopeManager.
  @protected
  set active(Scope value);
}
