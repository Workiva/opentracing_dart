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
  group('errors: verify', () {
    test('that SpanContextCorruptedError properly serializes to string.', () {
      String message = "testMessage";
      SpanContextCorruptedError error = SpanContextCorruptedError(message);
      expect(error.toString(), equals('SpanContextCorruptedError: $message'));
    });

    test('that InvalidCarrierFormatError properly serializes to string.', () {
      String message = "testMessage";
      InvalidCarrierFormatError error = InvalidCarrierFormatError(message);
      expect(error.toString(), equals('InvalidCarrierFormatError: $message'));
    });
  });
}
