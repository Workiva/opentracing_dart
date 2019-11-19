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

import 'package:opentracing/src/abstract_span.dart';
import 'package:test/test.dart';

import 'package:opentracing/noop_tracer.dart';

void main() {
  group('noopSpan: verify', () {
    test('that NoopSpan is inert', () {
      NoopSpan span = NoopSpan();
      expect(span.context, isA<NoopSpanContext>());
      expect(span.parentContext, isNull);
      expect(span.duration, isNull);
      expect(span.endTime, isNull);
      expect(span.logData, isNull);
      expect(span.operationName, isNull);
      expect(span.references, isNull);
      expect(span.startTime, isNull);
      expect(span.tags, isNull);
      span.addTags(<String, dynamic>{'testKey': 'testValue'});
      expect(span.tags, isNull);
      span.finish();
      expect(span.endTime, isNull);
      span.log('event');
      expect(span.logData, isNull);
      span.setTag('testKey', 'testValue');
      expect(span.tags, isNull);

      span.whenFinished.then(
          // ignore: STRONG_MODE_DOWN_CAST_COMPOSITE
          expectAsync1((Span span) {
        expect(span, isNull);
      }, count: 1));
    });
  });
}
