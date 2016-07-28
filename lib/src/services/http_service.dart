/**
 * Created by lejard_h on 23/12/15.
 */

import "dart:async";
import "dart:convert";
import "dart:html";

import "package:polyce/src/services/polyce_service.dart";

String get json_format => "json";

class HttpResponse {
  HttpRequest request;

  dynamic body;

  num get statusCode => request?.status;
  String get statusTest => request.statusText;

  bool get isSuccesful => statusCode >= 200 && statusCode < 300;

  HttpResponse.fromHttpRequest(HttpRequest req) {
    body = req.responseText;
  }
}

@Service()
class HttpService extends PolyceService {
  HttpService();

  static String data_format = json_format;

  Future<HttpResponse> delete(String url,
      {String responseType,
      bool withCredentials,
      String mimeType,
      Map<String, dynamic> parameters,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers,
      void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
        method: "DELETE",
        responseType: responseType ?? data_format,
        withCredentials: withCredentials,
        requestHeaders: headers,
        mimeType: mimeType,
      onProgress: onProgress);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  Future<HttpResponse> get(String url,
    {String responseType,
    bool withCredentials,
    String mimeType,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
      method: "GET",
      responseType: responseType ?? data_format,
      withCredentials: withCredentials,
      requestHeaders: headers,
      mimeType: mimeType,
      onProgress: onProgress);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  Future<HttpResponse> head(String url,
    {String responseType,
    bool withCredentials,
    String mimeType,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
      method: "HEAD",
      responseType: responseType ?? data_format,
      withCredentials: withCredentials,
      requestHeaders: headers,
      mimeType: mimeType,
      onProgress: onProgress);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  Future<HttpResponse> patch(String url,
    dynamic data,
    {String responseType,
    bool withCredentials,
    String mimeType,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
      method: "PATCH",
      responseType: responseType ?? data_format,
      withCredentials: withCredentials,
      requestHeaders: headers,
      mimeType: mimeType,
      onProgress: onProgress,
      sendData: data);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  Future<HttpResponse> post(String url,
    dynamic data,
    {String responseType,
    bool withCredentials,
    String mimeType,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
      method: "POST",
      responseType: responseType ?? data_format,
      withCredentials: withCredentials,
      requestHeaders: headers,
      mimeType: mimeType,
      onProgress: onProgress,
      sendData: data);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  Future<HttpResponse> put(String url,
    dynamic data,
    {String responseType,
    bool withCredentials,
    String mimeType,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    void onProgress(ProgressEvent e)}) async {
    HttpRequest req = await HttpRequest.request(_constructUrl(url, parameters, queryParameters),
      method: "PUT",
      responseType: responseType ?? data_format,
      withCredentials: withCredentials,
      requestHeaders: headers,
      mimeType: mimeType,
      onProgress: onProgress,
      sendData: data);

    return decode(new HttpResponse.fromHttpRequest(req));
  }

  HttpResponse decode(HttpResponse res) {
    if (res.body != null && res.request.responseType == json_format) {
      res.body = JSON.decode(res.body);
    }
    return res;
  }

  _constructUrl(String url, Map parameters, Map queryParameters) {
    url = replaceParameters(url, parameters);
    url = addQueryParameters(url, queryParameters);
    return url;
  }

  String replaceParameters(String path, Map<String, dynamic> parameters) {
    parameters?.forEach((String key, dynamic value) {
      path = path.replaceAll("/:$key", "/${Uri.encodeComponent(value.toString())}");
    });
    path = path.replaceAll("/:", "/");
    return path;
  }

  String addQueryParameters(String path, Map<String, dynamic> parameters) {
    if (parameters != null && parameters.isNotEmpty) {
      path += "?";
      parameters?.forEach((String key, dynamic value) {
        path = "${path}${Uri.encodeQueryComponent(key)}=${Uri
          .encodeQueryComponent(value.toString())}&";
      });
    }
    return path;
  }
}
