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

import 'constants.dart' as constants;
import 'span_context.dart';

/// Pairs a reference type constant (e.g., [referenceChildOf] or [referenceFollowsFrom])
/// with the [SpanContext] it points to.
///
/// See the exported [childOf] and [followsFrom] functions in [tracer.dart]
class Reference {
  /// The Reference type (e.g., referenceChildOf or referenceFollowsFrom).
  String referenceType;

  /// The SpanContext being referred to (e.g., the parent in a referenceChildOf Reference).
  SpanContext referencedContext;

  /// Returns a Reference object identified as being a child of [referencedContext]
  Reference.childOf(this.referencedContext) {
    referenceType = constants.referenceChildOf;
  }

  /// Returns a Reference object identified as following from [referencedContext]
  Reference.followsFrom(this.referencedContext) {
    referenceType = constants.referenceFollowsFrom;
  }
}
