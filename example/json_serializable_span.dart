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
//
// ignore_for_file: public_member_api_docs
import 'package:opentracing/opentracing.dart';

/// Abstract class that identifies other classes being serializable as json.
///
/// Implementing this class will enable a class to be serialized using the
/// JSON.encode method.
class JsonSerializableSpan {
  static const String versionField = 'version';
  static const String traceIdField = 'traceId';
  static const String spanIdField = 'spanId';
  static const String sampledField = 'sampled';
  static const String baggageField = 'baggage';
  static const String parentSpanIdField = 'parentSpanId';
  static const String operationField = 'operation';
  static const String startField = 'start';
  static const String durationField = 'duration';
  static const String tagsField = 'tags';
  static const String logsField = 'logs';

  Span span;

  JsonSerializableSpan(this.span);

  Map<String, dynamic> toJson() {
    return getFields();
  }

  Map<String, dynamic> getFields() {
    final fieldMap = <String, dynamic>{};
    fieldMap[versionField] = '';
    fieldMap[traceIdField] = span?.context?.traceId;
    fieldMap[spanIdField] = span?.context?.spanId;
    fieldMap[sampledField] = span?.context?.sampled ?? false;
    fieldMap[baggageField] = span?.context?.baggage;
    fieldMap[parentSpanIdField] = span?.parentContext?.spanId ?? '';
    fieldMap[operationField] = span?.operationName;
    fieldMap[startField] = span?.startTime?.toUtc()?.toIso8601String();
    fieldMap[durationField] = span?.duration?.inMilliseconds;
    fieldMap[tagsField] = span?.tags;
    fieldMap[logsField] = span?.logData;

    return fieldMap;
  }
}
