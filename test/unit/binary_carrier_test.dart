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

import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:opentracing/opentracing.dart';

void main() {
  group('binary carrier: verify', () {
    test('buffer can be set in constructor.', () {
      ByteBuffer buffer = Uint8List(8).buffer;
      BinaryCarrier carrier = BinaryCarrier(buffer);

      expect(carrier.buffer, same(buffer));
    });

    test('buffer can be set after construction.', () {
      ByteBuffer buffer = Uint8List(8).buffer;
      BinaryCarrier carrier = BinaryCarrier(buffer);
      ByteBuffer newBuffer = Uint8List(4).buffer;
      carrier.buffer = newBuffer;

      expect(carrier.buffer, same(newBuffer));
    });
  });
}
