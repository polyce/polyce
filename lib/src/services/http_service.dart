/**
 * Created by lejard_h on 23/12/15.
 */

import "dart:async";
import "dart:convert";

import "package:http/http.dart";
import "package:http/browser_client.dart";
import "package:polyce/polyce.dart";
import "package:dogma_convert/convert.dart";

String get json_format => "json";

class HttpResponse {
  Response response;
  dynamic convertedBody;

  num get statusCode => response?.statusCode;
}

@Service()
class HttpService extends PolyceService {

  static HttpService _instance;

  HttpService.constructor() : super.constructor() {

  }

  factory HttpService() {
    if (_instance == null) {
      _instance = new HttpService.constructor();
    }
    return _instance;
  }

  static String data_format = json_format;

  BrowserClient _http = new BrowserClient();

  dynamic encode(dynamic body, ModelEncoder encoder) {
    dynamic _body = body;
    if (body is PolyceModel) {
      _body = body.encode();
    } else if (encoder != null) {
      _body = encoder.convert(_body);
    }
    if (data_format == json_format) {
      _body = JSON.encode(_body);
    }
    return _body;
  }

  Future<HttpResponse> delete(String url,
      {Map params,
      Map<String, String> headers,
      ModelDecoder decoder
      }) async {
    HttpResponse res = new HttpResponse();
    res.response =
    await _http.delete(_constructUrlParams(url, params), headers: headers);
    return decode(res, decoder);
  }

  Future<HttpResponse> get(String url,
      {Map params,
      Map<String, String> headers,
      ModelDecoder decoder}) async {
    HttpResponse res = new HttpResponse();
    res.response =
    await _http.get(_constructUrlParams(url, params), headers: headers);
    return decode(res, decoder);
  }

  Future<HttpResponse> head(String url,
      {Map params,
      Map<String, String> headers,
      ModelDecoder decoder}) async {
    HttpResponse res = new HttpResponse();
    res.response =
    await _http.head(_constructUrlParams(url, params), headers: headers);
    return decode(res, decoder);
  }

  Future<HttpResponse> patch(String url,
      {body,
      Map params,
      Map<String, String> headers,
      Encoding encoding,
      ModelDecoder decoder,
      ModelEncoder encoder}) async {
    HttpResponse res = new HttpResponse();

    res.response = await _http.patch(_constructUrlParams(url, params),
        body: encode(body, encoder), headers: headers, encoding: encoding);
    return decode(res, decoder);
  }

  Future<HttpResponse> post(String url,
      {body,
      Map params,
      Map<String, String> headers,
      Encoding encoding,
      ModelDecoder decoder,
      ModelEncoder encoder}) async {
    HttpResponse res = new HttpResponse();
    res.response = await _http.post(_constructUrlParams(url, params),
        body: encode(body, encoder), headers: headers, encoding: encoding);
    return decode(res, decoder);
  }

  Future<HttpResponse> put(String url,
      {body,
      Map params,
      Map<String, String> headers,
      Encoding encoding,
      ModelDecoder decoder,
      ModelEncoder encoder}) async {
    HttpResponse res = new HttpResponse();
    res.response = await _http.put(_constructUrlParams(url, params),
        body: encode(body, encoder), headers: headers, encoding: encoding);
    return decode(res, decoder);
  }

  dynamic _decode(dynamic data, ModelDecoder decoder) {
    if (data is Map) {
      data = decoder.convert(data);
    } else if (data is List) {
      data = (data as List).map((dynamic _data) {
        return _decode(_data, decoder);
      });
    }
    return data;
  }

  HttpResponse decode(HttpResponse res, ModelDecoder decoder) {
    if (decoder != null && res.response?.body != null) {
      if (data_format == json_format) {
        res.convertedBody = JSON.decode(res.response?.body);
      }
      if (decoder != null) {
        res.convertedBody = _decode(res.convertedBody, decoder);
      }
    }
    return res;
  }

  _constructUrlParams(String url, Map params) {
    if (params != null && params.length > 0) {
      url += "?";
      params.forEach((key, value) {
        url += "$key=$value&";
      });
    }
    return url;
  }

  insertParamsToUri(String uri, Map<String, dynamic> params) {
    params?.forEach((String key, value) {
      if (value != null && uri.contains(":$key")) {
        uri = uri.replaceFirst(":$key", Uri.encodeComponent(value));
      }
    });
    return uri;
  }

  initialize() {}
}