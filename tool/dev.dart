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

library tool.dev;

import 'dart:async';
import 'package:dart_dev/dart_dev.dart' show dev, config;

Future main(List<String> args) async {
  // Define the entry points for static analysis.
  config.analyze
    ..entryPoints = <String>['example', 'lib/', 'test/']
    ..strong = true
    ..fatalHints = true
    ..fatalWarnings = true;

  // Define the directories where the LICENSE should be applied.
  config.copyLicense.directories = <String>[
    'example',
    'lib/',
    'test/',
    'tool/'
  ];

  // Configure whether or not the HTML coverage report should be generated.
  config.coverage.html = true;

  // Configure the port on which examples should be served.
  config.examples.port = 9000;

  // Define the directories to include when running the
  // Dart formatter.
  config.format.paths = <String>['example', 'lib/', 'test/', 'tool/'];

  // Define the location of your test suites.
  config.test
    ..unitTests = <String>['test/unit/']
    ..integrationTests = <String>['test/integration/']
    ..platforms = <String>['vm', 'content-shell'];

  // Execute the dart_dev tooling.
  await dev(args);
}
