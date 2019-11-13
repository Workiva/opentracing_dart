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
import 'package:opentracing/opentracing.dart';

void main() {
  group('SpanContext: verify', () {
    test('that SpanContext can be constructed without any params.', () {
      SpanContext context = SpanContext();
      expect(context.traceId, isNull);
      expect(context.spanId, isNull);
      expect(context.sampled, isFalse);
    });

    test('that SpanContext can be constructed properly.', () {
      int expectedTraceId = 1;
      int expectedSpanId = 2;
      bool expectedSampled = false;
      SpanContext context = SpanContext(
          traceId: expectedTraceId,
          spanId: expectedSpanId,
          sampled: expectedSampled);
      expect(context.traceId, expectedTraceId);
      expect(context.spanId, expectedSpanId);
      expect(context.sampled, expectedSampled);
    });

    test('that SpanContext bagage can be set, retrieved and iterated.', () {
      int expectedItemCount = 10;
      SpanContext context = SpanContext();
      for (int i = 0; i < expectedItemCount; i++) {
        context.setBaggageItem('item:$i', 'value:$i');
      }

      for (int i = 0; i < expectedItemCount; i++) {
        expect(context.baggage['item:$i'], equals('value:$i'));
      }

      for (int i = 0; i < expectedItemCount; i++) {
        expect(context.getBaggageItem('item:$i'), equals('value:$i'));
      }

      int count = 0;
      context.forEachBaggageItem((dynamic value) {
        expect(value, equals(context.baggage['item:$count']));
        count++;
        return true;
      });

      expect(count, equals(expectedItemCount));
    });
  });
}
