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
  group('LogData', () {
    final DateTime timestamp = new DateTime.now();
    final String event = 'testEvent';
    final Error error = new Error();
    final String errorKind = 'testKind';
    final String message = 'message';
    final StackTrace stackTrace = StackTrace.current;

    final String customField = 'customField';
    final String customFieldData = 'customFieldData';

    test('can be properly constructed', () {
      final LogData logData = new LogData(
        event,
        errorKind: errorKind,
        errorObject: error,
        fields: {
          customField: customFieldData,
        },
        message: message,
        stackTrace: stackTrace,
        timestamp: timestamp,
      );

      expect(logData.timestamp, timestamp);
      expect(logData.event, event);
      expect(logData.errorKind, errorKind);
      expect(logData.errorObject, error);
      expect(logData.fields[customField], customFieldData);
      expect(logData.message, message);
      expect(logData.stackTrace, stackTrace);
    });
  });
}
