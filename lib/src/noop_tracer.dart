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

import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of [AbstractTracer] in which all operations are no-op
class NoopTracer extends AbstractTracer {
  static ScopeManager _scopeManager = NoopScopeManager();

  @override
  NoopSpan startSpan(String operationName,
      {SpanContext childOf,
      List<Reference> references,
      Map<String, dynamic> tags,
      DateTime startTime}) {
    return scopeManager.active.span;
  }

  @override
  void inject(SpanContext spanContext, String format, dynamic carrier) {}

  @override
  SpanContext extract(String format, dynamic carrier) {
    return scopeManager?.active?.span?.context;
  }

  @override
  Future<dynamic> flush() async {}

  @override
  ScopeManager get scopeManager => _scopeManager;

  @override
  set scopeManager(ScopeManager value) {
    _scopeManager = value;
  }
}
