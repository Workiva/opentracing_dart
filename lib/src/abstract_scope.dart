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

/// A Scope formalizes the activation and deactivation of a [Span], usually
/// from a CPU standpoint.
///
/// Many times a [Span] will be extant ([Span.finish] has not been called)
/// despite being in a non-runnable state from a CPU/scheduler standpoint. For
/// instance, a [Span] representing the client side of an RPC will be unfinished
/// but blocked on IO while the RPC is still outstanding. A Scope defines when
/// a given [Span] is scheduled and on the path.
abstract class Scope {
  /// Mark the end of the active period for the current thread and Scope,
  /// updating the [ScopeManager.active] in the process.
  ///
  /// NOTE: Calling 'close' more than once on a single Scope instance
  /// leads to undefined behavior.
  void close();

  /// The Span that's been scoped by this Scope.
  Span get span;
}
