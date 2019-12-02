# OpenTracing API for Dart

This library is the Open Tracing API written in Dart. It is intended for use both on the server and in the browser.

## Required Reading

To fully understand this platform API, it's helpful to be familiar with the [OpenTracing project](http://opentracing.io) and
[terminology](http://opentracing.io/spec/) more generally.

## Quick Start

Add the package to your pubspec:

```yaml
dependencies:
  opentracing: ^1.0.0
```

In your dart code, add instrumentation to the operations to be tracked. This is composed primarily of using "spans" around operations of interest and adding log statements to capture useful data relevant to those operations.

```dart
  var tracer = globalTracer();
  
  Span span = tracer.startSpan('http_request');

  HttpRequest.getString('http://httpstat.us/200').then((String result){
    span.log('data_received', payload: result);
  }).catchError((error){
    span.log('request_error', payload: error);
  }).whenComplete((){
    span.log('request_end');
    span.finish();
  });
```

The default behavior of the `opentracing` package is to act as a "no-op" implementation.

To capture and make the tracing data actionable, the `Tracer` object should be initialized with the OpenTracing implementation of your choice as in the example code below:

```dart
    initGlobalTracer(new CustomTracer());
```

Note: The underlying implementation object is shared between all inclusions of the `opentracing` package, so `initGlobalTracer` needs to only be called once during initialization.

## Development Information

See the [OpenTracing website](http://opentracing.io/) for general information on contributing to OpenTracing.

The project examples are run by `webdev_proxy`. Run:
```shell
pub global activate webdev
pub global activate webdev_proxy
webdev_proxy serve -- example:8080
```


## Dart OpenTracing Implementations

### OpenTracing tracer implementations

*This section is intended for developers wishing to* ***implement their own tracers***. *Developers who simply wish to* ***use OpenTracing*** *can safely ignore this information.*

### Custom tracer implementation

Implementations can implement `Tracer`, extend `Span`, and implement or extend the other API classes to build a OpenTracing tracer.

See [basictracer-dart](https://github.com/Workiva/basictracer-dart) for an example.

### API compatibility testing

Coming soon / todo
