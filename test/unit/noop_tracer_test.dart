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

import 'package:test/test.dart';
import 'package:opentracing/noop_tracer.dart';

void main() {
  test('Verify startSpan returns a NoopSpan', () {
    NoopTracer noopTracer = NoopTracer();
    NoopSpan noopSpan = noopTracer.startSpan("opName");
    expect(noopSpan, isA<NoopSpan>());
    NoopSpanContext expectedContext = NoopSpanContext();
    expect(noopSpan.context.traceId, expectedContext.traceId);
    expect(noopSpan.context.spanId, expectedContext.spanId);
    expect(noopSpan.context.sampled, expectedContext.sampled);
    expect(noopSpan.context.baggage, expectedContext.baggage);
  });

  test('Verify flush does nothing.', () {
    NoopTracer noopTracer = NoopTracer();
    NoopSpan noopSpan = noopTracer.startSpan("opName");
    noopTracer.flush();
    expect(noopSpan, isA<NoopSpan>());
    NoopSpanContext expectedContext = NoopSpanContext();

    expect(noopSpan.context.traceId, expectedContext.traceId);
    expect(noopSpan.context.spanId, expectedContext.spanId);
    expect(noopSpan.context.sampled, expectedContext.sampled);
    expect(noopSpan.context.baggage, expectedContext.baggage);
  });

  test('Verify startSpan returns NoopSpan from NoopScopeManager', () {
    NoopTracer noOpTracer = NoopTracer();
    expect(noOpTracer.startSpan(''), same(noOpTracer.activeSpan));
  });
}
