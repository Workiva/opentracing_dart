FROM google/dart:2.0.0 as dart2
ARG BUILD_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_TAG
ARG GIT_COMMIT_RANGE
ARG GIT_HEAD_URL
ARG GIT_MERGE_HEAD
ARG GIT_MERGE_BRANCH

WORKDIR /build/
ADD . /build/
RUN pub get && \
    dartfmt --set-exit-if-changed -n lib test example && \
    dartanalyzer lib test example && \
    pub run build_runner test -- -p vm -p chrome


FROM google/dart:1.24.3 as dart1
ARG BUILD_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_TAG
ARG GIT_COMMIT_RANGE
ARG GIT_HEAD_URL
ARG GIT_MERGE_HEAD
ARG GIT_MERGE_BRANCH

WORKDIR /build/
ADD . /build/
RUN pub get && \
    dartfmt --set-exit-if-changed -n lib test example && \
    dartanalyzer lib test example && \
    pub run test -p vm -p chrome

ARG BUILD_ARTIFACTS_BUILD=/build/pubspec.lock

FROM scratch

