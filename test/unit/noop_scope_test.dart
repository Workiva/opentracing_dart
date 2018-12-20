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
  group('NoOpScope: verify', () {
    test('that NoOpScope is inert', () {
      NoOpScope scope = new NoOpScope();
      expect(scope.span, new isInstanceOf<NoopSpan>());
      expect(scope.close, isNot(throwsException));
    });

    test('that NoOpScope.span is same instance', () {
      NoOpScope scopeOne = new NoOpScope();
      NoOpScope scopeTwo = new NoOpScope();
      expect(identical(scopeOne.span, scopeTwo.span), isTrue);
    });
  });
}
