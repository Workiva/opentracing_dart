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

import 'package:opentracing/opentracing.dart';

/// Abstract class that identifies other classes being serializable as json.
///
/// Implementing this class will enable a class to be serialized using the
/// JSON.encode method.
class JsonSerializableSpan {
  // ignore: public_member_api_docs
  static const String versionField = 'version';
  // ignore: public_member_api_docs
  static const String traceIdField = 'traceId';
  // ignore: public_member_api_docs
  static const String spanIdField = 'spanId';
  // ignore: public_member_api_docs
  static const String sampledField = 'sampled';
  // ignore: public_member_api_docs
  static const String baggageField = 'baggage';
  // ignore: public_member_api_docs
  static const String parentSpanIdField = 'parentSpanId';
  // ignore: public_member_api_docs
  static const String operationField = 'operation';
  // ignore: public_member_api_docs
  static const String startField = 'start';
  // ignore: public_member_api_docs
  static const String durationField = 'duration';
  // ignore: public_member_api_docs
  static const String tagsField = 'tags';
  // ignore: public_member_api_docs
  static const String logsField = 'logs';

  // ignore: public_member_api_docs
  Span span;

  // ignore: public_member_api_docs
  JsonSerializableSpan(this.span);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return getFields();
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> getFields() {
    Map<String, dynamic> fieldMap = <String, dynamic>{};
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
