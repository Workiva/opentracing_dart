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
      NoopScopeManager scopeManager = new NoopScopeManager();
      bool finishOnSpanClose = false;
      expect(scopeManager.active, new isInstanceOf<NoopScope>());
      scopeManager.activate(spanA, finishOnSpanClose);
      expect(scopeManager.active.span, same(spanA));
      expect(scopeManager.activate(spanA, finishOnSpanClose),
          new isInstanceOf<NoopScope>());
    });

    test('that NoOpScope.span is same instance', () {
      NoopScopeManager scopeManagerOne = new NoopScopeManager();
      NoopScopeManager scopeManagerTwo = new NoopScopeManager();
      expect(scopeManagerTwo.active, same(scopeManagerOne.active));
    });
  });
}
