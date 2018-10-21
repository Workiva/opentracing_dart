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
  group('NoOpScopeManager: verify', () {
    test('that NoOpScope is inert', () {
      NoopSpan spanA = new NoopSpan();
      NoOpScopeManager scopeManager = new NoOpScopeManager();
      expect(scopeManager.active, new isInstanceOf<NoOpScope>());
      scopeManager.activate(spanA);
      expect(identical(spanA, scopeManager.active), isFalse);
      expect(scopeManager.activate(spanA), new isInstanceOf<NoOpScope>());
    });

    test('that NoOpScope.span is same instance', () {
      NoOpScopeManager scopeManagerOne = new NoOpScopeManager();
      NoOpScopeManager scopeManagerTwo = new NoOpScopeManager();
      expect(identical(scopeManagerOne.active, scopeManagerTwo.active), isTrue);
    });
  });
}
