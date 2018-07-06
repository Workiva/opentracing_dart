@TestOn('browser')
library test.generated_runner;

// Generated by `pub run dart_dev gen-test-runner -d test/ -e Environment.browser --no-genHtml`

import './unit/abstract_tracer_test.dart' as unit_abstract_tracer_test;
import './unit/binary_carrier_test.dart' as unit_binary_carrier_test;
import './unit/errors_test.dart' as unit_errors_test;
import './unit/global_tracer_test.dart' as unit_global_tracer_test;
import './unit/noop_span_test.dart' as unit_noop_span_test;
import './unit/noop_tracer_test.dart' as unit_noop_tracer_test;
import './unit/reference_test.dart' as unit_reference_test;
import './unit/span_context_test.dart' as unit_span_context_test;
import './unit/span_log_test.dart' as unit_span_log_test;
import 'package:test/test.dart';

void main() {
  unit_abstract_tracer_test.main();
  unit_binary_carrier_test.main();
  unit_errors_test.main();
  unit_global_tracer_test.main();
  unit_noop_span_test.main();
  unit_noop_tracer_test.main();
  unit_reference_test.main();
  unit_span_context_test.main();
  unit_span_log_test.main();
}