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

/// This error describes the state of a SpanContext being corrupt.
class SpanContextCorruptedError extends Error {
  /// The message associated with this error.
  String message;

  /// Returns an instance of the SpanContextCorruptedError
  SpanContextCorruptedError(this.message);

  @override
  String toString() => 'SpanContextCorruptedError: $message';
}

/// This error describes the state of a Carrier Format being invalid.
class InvalidCarrierFormatError extends Error {
  /// The message associated with this error.
  String message;

  /// Returns an instance of the InvalidCarrierFormatError
  InvalidCarrierFormatError(this.message);

  @override
  String toString() => 'InvalidCarrierFormatError: $message';
}
