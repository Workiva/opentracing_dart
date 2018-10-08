FROM google/dart:2.0.0 as dart2
WORKDIR /build/
ADD pubspec.yaml /build
RUN npm install && \
    pub get && \
    dartfmt --set-exit-if-changed -n lib test example && \
    dartanalyzer lib test example && \
    pub run build_runner test -- -p vm -p chrome


FROM google/dart:1.24.3 as dart1
WORKDIR /build/
ADD pubspec.yaml /build
RUN npm install && \
    pub get && \
    dartfmt --set-exit-if-changed -n lib test example && \
    dartanalyzer lib test example && \
    pub run test -p vm -p chrome

ARG BUILD_ARTIFACTS_BUILD=/build/pubspec.lock

FROM scratch

