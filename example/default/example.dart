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
import 'dart:html';
import 'json_serializable_span.dart';
import 'package:opentracing/opentracing.dart';
import 'package:opentracing/src/global_tracer.dart';

/// Global Tracer
AbstractTracer tracer = globalTracer();

/// handler for Span finishing
void onFinished(Span span) {
  print(new JsonSerializableSpan(span).toJson());
}

void runTestCase(String url) {
  Span span = tracer.startSpan('http_request');
  span.whenFinished.then(onFinished);

  HttpRequest.getString(url).then((String result) {
    span.log(new LogData(
      'data_received',
      message: 'Received data',
      payload: result,
    ));
    span.setTag(SpanTag.error, false);
  }).catchError((error, trace) {
    span.log(new LogData(
      'request_error',
      errorObject: error,
    ));
    span.setTag(SpanTag.error, true);
  }).whenComplete(() {
    span.log(new LogData(
      'request_end',
    ));
    span.finish();
  });
}

void runSuccessCase() => runTestCase('http://httpstat.us/200');

void runFailureCase() => runTestCase('http://httpstat.us/500');

Future main() async {
  runSuccessCase();
  runFailureCase();
}
