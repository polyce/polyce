/**
 * Created by lejard_h on 23/12/15.
 */

import "dart:async";
import "dart:convert";
import "dart:html";

import "package:polyce/src/services/polyce_service.dart";

class PolyceHttpResponse {
  HttpRequest request;

  dynamic body;

  num get statusCode => request?.status;
  String get statusText => request.statusText;

  bool get isSuccesful => statusCode >= 200 && statusCode < 300;

  PolyceHttpResponse.fromHttpRequest(HttpRequest req) {
    body = req.responseText;
  }
}

typedef void progressRequest(ProgressEvent event);

class PolyceHttpRequest {
  String url;
  String method;
  dynamic data;
  String responseType;
  bool withCredentials;
  String mimeType;
  Map<String, dynamic> parameters;
  Map<String, dynamic> queryParameters;
  Map<String, dynamic> headers;

  PolyceHttpRequest(this.url, this.method,
      {this.data, this.responseType, this.withCredentials, this.mimeType, this.parameters, this.queryParameters, this.headers});

  static String replaceParameters(String path, Map<String, dynamic> parameters) {
    parameters?.forEach((String key, dynamic value) {
      path = path.replaceAll("/:$key", "/${Uri.encodeComponent(value.toString())}");
    });
    path = path.replaceAll("/:", "/");
    return path;
  }

  static String addQueryParameters(String path, Map<String, dynamic> parameters) {
    if (parameters != null && parameters.isNotEmpty) {
      path += "?";
      parameters?.forEach((String key, dynamic value) {
        path = "${path}${Uri.encodeQueryComponent(key)}=${Uri
          .encodeQueryComponent(value.toString())}&";
      });
    }
    return path;
  }

  String constructUrl() {
    String u = url;
    u = replaceParameters(u, parameters);
    u = addQueryParameters(u, queryParameters);
    return u;
  }
}

typedef PolyceHttpRequest requestInterceptor(PolyceHttpRequest request);
typedef PolyceHttpResponse responseInterceptor(PolyceHttpResponse response);

@Service()
class HttpService extends PolyceService {
  static String get json_format => "json";

  List<requestInterceptor> _requestInterceptors = [];
  List<responseInterceptor> _responseInterceptors = [];

  addResponseInterceptor(responseInterceptor interceptor) {
    if (!_responseInterceptors.contains(interceptor)) {
      _responseInterceptors.add(interceptor);
    }
  }

  addRequestInterceptor(requestInterceptor interceptor) {
    if (!_requestInterceptors.contains(interceptor)) {
      _requestInterceptors.add(interceptor);
    }
  }

  HttpService();

  String data_format = json_format;

  PolyceHttpRequest _interceptRequest(PolyceHttpRequest req) {
    for (requestInterceptor interceptor in _requestInterceptors) {
      req = interceptor(req);
    }
    return req;
  }

  PolyceHttpResponse _interceptResponse(PolyceHttpResponse req) {
    for (responseInterceptor interceptor in _responseInterceptors) {
      req = interceptor(req);
    }
    return req;
  }

  Future<PolyceHttpResponse> send(PolyceHttpRequest request, {void onProgress(ProgressEvent)}) async {
    request = _interceptRequest(request);

    HttpRequest req = await HttpRequest.request(request.constructUrl(),
        method: request.method,
        responseType: request.responseType ?? data_format,
        withCredentials: request.withCredentials,
        requestHeaders: request.headers,
        mimeType: request.mimeType,
        onProgress: onProgress);

    PolyceHttpResponse res = decode(new PolyceHttpResponse.fromHttpRequest(req));

    return _interceptResponse(res);
  }

  Future<PolyceHttpResponse> delete(String url,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "DELETE",
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  Future<PolyceHttpResponse> get(String url,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "GET",
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  Future<PolyceHttpResponse> head(String url,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "HEAD",
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  Future<PolyceHttpResponse> patch(String url, dynamic data,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "PATCH",
              data: data,
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  Future<PolyceHttpResponse> post(String url, dynamic data,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "POST",
              data: data,
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  Future<PolyceHttpResponse> put(String url, dynamic data,
          {String responseType,
          bool withCredentials,
          String mimeType,
          Map<String, dynamic> parameters,
          Map<String, dynamic> queryParameters,
          Map<String, dynamic> headers,
          void onProgress(ProgressEvent e)}) async =>
      send(
          new PolyceHttpRequest(url, "PUT",
              data: data,
              responseType: responseType,
              withCredentials: withCredentials,
              headers: headers,
              parameters: parameters,
              queryParameters: queryParameters),
          onProgress: onProgress);

  PolyceHttpResponse decode(PolyceHttpResponse res) {
    if (res.body != null && res.request.responseType == json_format) {
      res.body = JSON.decode(res.body);
    }
    return res;
  }
}
