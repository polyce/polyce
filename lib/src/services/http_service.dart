/**
 * Created by lejard_h on 23/12/15.
 */

import "dart:async";
import "dart:convert";

import "package:http/http.dart";
import "package:http/browser_client.dart";
import "package:polyce/src/services/polyce_service.dart";

String get json_format => "json";

class HttpResponse {
  Response response;

  dynamic body;

  num get statusCode => response?.statusCode;
  bool get isSuccesful => statusCode >= 200 && statusCode < 300;

  HttpResponse(this.response);
}

@Service()
class HttpService extends PolyceService {

  static HttpService _instance;

  HttpService.constructor() : super.constructor();

  factory HttpService() {
    if (_instance == null) {
      _instance = new HttpService.constructor();
    }
    return _instance;
  }

  static String data_format = json_format;

  BrowserClient _http = new BrowserClient();

  Future<HttpResponse> delete(String url,
      {Map<String, dynamic> parameters,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers}) async {
    HttpResponse res = new HttpResponse(await _http.delete(_constructUrl(url, parameters, queryParameters), headers: headers));
    return decode(res);
  }

  Future<HttpResponse> get(String url,
    {Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers}) async {
    HttpResponse res = new HttpResponse( await _http.get(_constructUrl(url, parameters, queryParameters), headers: headers));
    return decode(res);
  }

  Future<HttpResponse> head(String url,
    {Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers}) async {
    HttpResponse res = new HttpResponse( await _http.head(_constructUrl(url, parameters, queryParameters), headers: headers));
    return decode(res);
  }

  Future<HttpResponse> patch(String url,
      {dynamic body,
      Map<String, dynamic> parameters,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers,
      Encoding encoding}) async {

    HttpResponse res = new HttpResponse(await _http.patch(_constructUrl(url, parameters, queryParameters),
        body: body, headers: headers, encoding: encoding));
    return decode(res);
  }

  Future<HttpResponse> post(String url,
    {dynamic body,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    Encoding encoding}) async {
    HttpResponse res = new HttpResponse(await _http.post(_constructUrl(url, parameters, queryParameters),
      body: body, headers: headers, encoding: encoding));
    return decode(res);
  }

  Future<HttpResponse> put(String url,
    {dynamic body,
    Map<String, dynamic> parameters,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    Encoding encoding}) async {
    HttpResponse res = new HttpResponse(await _http.put(_constructUrl(url, parameters, queryParameters),
      body: body, headers: headers, encoding: encoding));
    return decode(res);
  }

  HttpResponse decode(HttpResponse res) {
    res.body = res.response.body;
    if (res.response.body != null && res.response.headers["content-type"] == "application/json" && data_format == json_format) {
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

  initialize() {}
}

HttpService http_service = new HttpService();