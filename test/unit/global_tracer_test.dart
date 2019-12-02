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

import 'package:test/test.dart';

import 'package:opentracing/opentracing.dart';
import 'package:opentracing/noop_tracer.dart';

void main() {
  test('Global tracer is a singleton', () {
    AbstractTracer tracerOne = globalTracer();
    AbstractTracer tracerTwo = globalTracer();
    expect(tracerOne, same(tracerTwo));
  });

  test('Verify InitGlobalTracer changes the global tracer', () {
    AbstractTracer tracer = globalTracer();
    expect(tracer, isA<NoopTracer>());

    TestTracer testTracer = TestTracer();
    initGlobalTracer(testTracer);

    AbstractTracer newGlobalTracer = globalTracer();
    expect(newGlobalTracer, testTracer);
  });
}

/// This tracer is only used for testing.
class TestTracer extends AbstractTracer {
  @override
  NoopSpan startSpan(String operationName,
      {SpanContext childOf,
      List<Reference> references,
      Map<String, dynamic> tags,
      DateTime startTime}) {
    return null;
  }

  @override
  void inject(SpanContext spanContext, String format, dynamic carrier) {}

  @override
  SpanContext extract(String format, dynamic carrier) {
    return NoopSpanContext();
  }

  @override
  Future<dynamic> flush({Function callback = null}) async {}

  @override
  Span get activeSpan {
    return NoopSpan();
  }

  @override
  ScopeManager get scopeManager => null;

  @override
  set scopeManager(ScopeManager value) {
    // no op
  }
}
