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

import 'dart:async';

import 'package:opentracing/noop_tracer.dart';
import 'package:opentracing/opentracing.dart';

/// The No-op implementation of a [Span] in which all operations are no-ops.
class NoopSpan implements Span {
  static NoopSpanContext _noopSpanContext = NoopSpanContext();

  @override
  SpanContext context = _noopSpanContext;

  @override
  SpanContext parentContext;

  @override
  void addTags(Map<String, dynamic> keyValuePairs) {}

  @override
  Duration get duration => null;

  @override
  DateTime get endTime => null;

  @override
  void finish({DateTime finishTime}) {}

  @override
  void log(String event, {DateTime timestamp, Object payload}) {}

  @override
  List<LogData> get logData => null;

  @override
  String get operationName => null;

  @override
  List<Reference> get references => null;

  @override
  void setTag(String key, dynamic value) {}

  @override
  DateTime get startTime => null;

  @override
  Map<String, dynamic> get tags => null;

  @override
  Future<Span> get whenFinished async {
    return Future<Span>.value(null);
  }

  @override
  set startTime(DateTime value) {}
}
