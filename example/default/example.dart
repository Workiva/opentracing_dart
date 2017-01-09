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

import 'dart:html';
import 'json_serializable_span.dart';
import 'package:opentracing/opentracing_dart.dart';
import 'package:opentracing/src/global_tracer.dart';

/// Global Tracer
AbstractTracer tracer = globalTracer();

/// handler for Span finishing
void onFinished(Span span) {
  print(new JsonSerializableSpan(span).toJson());
}

/// Runs the success case
void runSuccessCase() {
  Span span = tracer.startSpan('http_request');
  span.whenFinished.then(onFinished);

  HttpRequest.getString('http://httpstat.us/200').then((String result) {
    span.log('data_received', payload: result);
  }).catchError((dynamic error) {
    span.log('request_error', payload: error);
  }).whenComplete(() {
    span.log('request_end');
    span.finish();
  });
}

/// Runs the failure case
void runFailureCase() {
  Span span = tracer.startSpan('http_request');
  span.whenFinished.then(onFinished);

  HttpRequest.getString('http://httpstat.us/500').then((String result) {
    span.log('data_received', payload: result);
  }).catchError((error) {
    span.log('request_error', payload: error);
  }).whenComplete(() {
    span.log('request_end');
    span.finish();
  });
}

main() async {
  runSuccessCase();
  runFailureCase();
}
