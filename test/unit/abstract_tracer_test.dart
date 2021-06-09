// @dart=2.7
// ^ Do not remove until migrated to null safety. More info at https://wiki.atl.workiva.net/pages/viewpage.action?pageId=189370832
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
import 'package:opentracing/opentracing.dart';

void main() {
  group('abstract carrier: verify', () {
    test('childOf returns proper Reference.', () {
      NoopTracer tracer = NoopTracer();
      Reference childOf = tracer.childOf(SpanContext());
      expect(childOf.referenceType, equals(referenceChildOf));
    });

    test('followsFrom returns proper Reference.', () {
      NoopTracer tracer = NoopTracer();
      Reference followsFrom = tracer.followsFrom(SpanContext());
      expect(followsFrom.referenceType, equals(referenceFollowsFrom));
    });
  });
}
