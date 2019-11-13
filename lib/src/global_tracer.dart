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

import "noop_tracer.dart";
import "abstract_tracer.dart";

/// GlobalTracer is the Tracer singleton that can be set using initGlobalTracer,
/// and gotten with globalTracer(). By default, the tracer in the singleton is set
/// to the NoopTracer.
class _GlobalTracer {
  static _GlobalTracer globalTracer = _GlobalTracer._internal();
  AbstractTracer tracer = NoopTracer();

  factory _GlobalTracer() {
    return globalTracer;
  }

  _GlobalTracer._internal();
}

/// Sets the opentracing.AbstractTracer singleton that is returned by globalTracer()
void initGlobalTracer(AbstractTracer tracer) {
  _GlobalTracer().tracer = tracer;
}

/// GlobalTracer returns the global singleton `AbstractTracer` implementation.
/// Before `initGlobalTracer()` is called, the `GlobalTracer()` is a noop
/// implementation that drops all data handed to it.
AbstractTracer globalTracer() {
  return _GlobalTracer().tracer;
}
