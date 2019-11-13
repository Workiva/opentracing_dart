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

import 'dart:math';

/// random number generator
final Random random = Random();

/// tracing specification version
final String opentracingVersion = '1.0';

/// Max possible integer value usable by Random.nextInt
/// Implementation note: The default implementation supports [max] values
/// between 1 and (1<<32) inclusive.
final int maxInt = 4294967296;

/// Represents [SpanContext]s in an opaque binary carrier.
///
/// [Tracer.inject()] will set the [BinaryFormat.buffer] field to a [List] containing
/// the injected binary data.
/// Any valid Object can be used as long as the [buffer] field of the object
/// can be set.
///
/// [Tracer.extract()] will look for [carrier.buffer], and that field is
/// expected to be a [List].
const String formatBinary = 'binary';

/// Represents [SpanContext]s using a Map<String, String> map as a carrier.
///
/// NOTE: Unlike [formatHttpHeaders], [formatTextMap] places no restrictions
/// on the characters used in either the keys or the values of the map
/// entries.
///
/// The [formatTextMap] carrier map may contain unrelated data (e.g.,
/// arbitrary gRPC metadata); as such, the [Tracer] implementation should use
/// a prefix or other convention to distinguish [Tracer]-specific key:value
/// pairs.
const String formatTextMap = 'text_map';

/// Represents [SpanContext]s using a character-restricted Map<String, String> as a carrier.
///
/// Keys and values in the [formatHttpHeaders] carrier must be suitable for
/// use as HTTP headers (without modification or further escaping). That is,
/// the keys have a greatly restricted character set, casing for the keys
/// may not be preserved by various intermediaries, and the values should be
/// URL-escaped.
///
/// The [formatHttpHeaders] carrier map may contain unrelated data (e.g.,
/// arbitrary HTTP headers); as such, the [Tracer] implementation should use a
/// prefix or other convention to distinguish [Tracer]-specific key:value
/// pairs.
const String formatHttpHeaders = 'http_headers';

/// A [Span] may be the "child of" a parent [Span]. In a “child of” reference,
/// the parent [Span] depends on the child [Span] in some capacity.
///
/// See more about reference types at http://opentracing.io/spec/
const String referenceChildOf = 'child_of';

/// Some parent [Span]s do not depend in any way on the result of their child
/// [Span]s. In these cases, we say merely that the child Span “follows from”
/// the parent [Span] in a causal sense.
///
/// See more about reference types at http://opentracing.io/spec/
const String referenceFollowsFrom = 'follows_from';
