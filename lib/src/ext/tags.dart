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

/// Here we define standard names for tags that can be added to [Span]s by the
/// instrumentation code. The actual tracing systems are not required to
/// retain these as tags in the stored [Span]s if they have other means of
/// representing the same data. For example, the spanKind='server' can be
/// inferred from a Zipkin span by the presence of ss/sr annotations.

/// Hints at relationship between [Span]s, e.g. client/server.
const String spanKind = 'span.kind';

/// Marks a [Span] representing the client-side of an RPC or other remote call.
const String spanKindRpcClient = 'client';

/// Marks a [Span] representing the server-side of an RPC or other remote call.
const String spanKindRpcServer = 'server';

/// Low-cardinality identifier of the module, library, or package that is generating a [Span].
const String component = 'component';

/// Determines the priority of sampling this [Span]. Expected [int].
const String samplingPriority = 'sampling.priority';

/// peer* tags can be emitted by either client-side of server-side to describe
/// the other side/service in a peer-to-peer communications, like an RPC call.

/// Identifies the service name of the peer.
const String peerService = 'peer.service';

/// Identifies the host name of the peer.
const String peerHostname = 'peer.hostname';

/// Identifies IP v4 host address of the peer. Expected [int].
const String peerHostIpV4 = 'peer.ipv4';

/// Identifies the IP v6 host address of the peer.
const String peerHostIpV6 = 'peer.ipv6';

/// Identifies the port number of the peer. Expect [int].
const String peerPort = 'peer.port';

/// HTTP tags

/// Identifies the URL of the request being handled in this segment of the trace,
/// in standard URI format. The protocol is optional.
const String httpUrl = 'http.url';

/// Identifies the HTTP method of the request. Both upper/lower case values are allowed.
const String httpMethod = 'http.method';

/// Identifies the numeric HTTP status code (200, 404, etc) of the HTTP response. Expected [int].
const String httpStatusCode = 'http.status_code';
