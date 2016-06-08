import "dart:async";
import "dart:convert";
import "package:dogma_convert/convert.dart";
import 'package:polyce/polyce.dart';
import "http_service.dart";

abstract class PolyceHttp<Model extends PolyceModel> {

  ModelDecoder<Model> get model_decoder;

  ModelEncoder<Model> get model_encoder;

  @override
  Future<HttpResponse> put(String url, {Model body, Map params, Map<String,
      String> headers, Encoding encoding, ModelDecoder decoder, ModelEncoder encoder}) =>
      http_service.put(url, body: body,
          params: params,
          headers: headers,
          encoding: encoding,
          decoder: model_decoder,
          encoder: model_encoder);

  @override
  Future<HttpResponse> post(String url, {Model body, Map params, Map<String,
      String> headers, Encoding encoding, ModelDecoder decoder, ModelEncoder encoder}) =>
      http_service.post(url, body: body,
          params: params,
          headers: headers,
          encoding: encoding,
          decoder: model_decoder,
          encoder: model_encoder);

  @override
  Future<HttpResponse> patch(String url, {Model body, Map params, Map<String,
      String> headers, Encoding encoding, ModelDecoder decoder, ModelEncoder encoder}) =>
      http_service.patch(url, body: body,
          params: params,
          headers: headers,
          encoding: encoding,
          decoder: model_decoder,
          encoder: model_encoder);

  @override
  Future<HttpResponse> head(String url,
      {Map params, Map<String, String> headers, ModelDecoder decoder}) =>
      http_service.head(url,
          params: params,
          headers: headers,
          decoder: model_decoder);

  @override
  Future<HttpResponse> get(String url,
      {Map params, Map<String, String> headers, ModelDecoder decoder}) =>
      http_service.get(url,
          params: params,
          headers: headers,
          decoder: model_decoder);

  @override
  Future<HttpResponse> delete(String url,
      {Map params, Map<String, String> headers, ModelDecoder decoder}) =>
      http_service.get(url,
          params: params,
          headers: headers,
          decoder: model_decoder);

}
