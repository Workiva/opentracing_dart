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

import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of a [ScopeManager] in which all operations are
/// no-ops.
class NoopScopeManager extends ScopeManager {
  /// Returns a new NoopScopeManager.
  NoopScopeManager() {
    _scope ??= NoopScope();
  }
  static Scope _scope;

  @override
  Scope activate(Span span, bool finishSpanOnClose) {
    _scope = NoopScope(span: span);
    return active;
  }

  @override
  Scope get active => _scope;

  @override
  set active(Scope value) {
    _scope = value;
  }
}
