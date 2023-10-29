import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:gigachat_app_unofficial/models/Message.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

const CLIENT_SECRET = "438dd078-f391-42d6-8149-574b68d74fa2";
const AUTH_DATA =
    "OTFlNWQ4MTEtNDliNC00ZmE1LWJmZDQtZWQ3MjQ1ZTVlOGQxOjQzOGRkMDc4LWYzOTEtNDJkNi04MTQ5LTU3NGI2OGQ3NGZhMg==";
const CLIENT_ID = "91e5d811-49b4-4fa5-bfd4-ed7245e5e8d1";
const SCOPE = "GIGACHAT_API_PERS";

class ApiClient {
  static HttpClient client = HttpClient();
  static final dio = Dio();

  static Future<String> fetchToken() async {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        client
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

    final res = await dio.post(
      'https://ngw.devices.sberbank.ru:9443/api/v2/oauth',
      data: {"scope": "GIGACHAT_API_PERS"},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization": "Bearer $AUTH_DATA",
          "RqUID": "7f0b1291-c7f3-43c6-bb2e-9f3efb2dc98e"
        },
      ),
    );

    return res.data["access_token"];
  }

  static Future<void> sendMessage(
    List<Message> context,
    Function(Message) onFetch,
  ) async {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        client
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

    Response<ResponseBody> rs = await dio.post<ResponseBody>(
      "https://gigachat.devices.sberbank.ru/api/v1/chat/completions",
      data: {
        "model": "GigaChat:latest",
        "stream": true,
        "messages": context
            .map(
              (e) => {
                "role": e.sentByUser ? "user" : "assistant",
                "content": e.text,
              },
            )
            .toList()
      },
      options: Options(
        headers: {
          "Authorization": "Bearer ${await fetchToken()}",
          "X-Client-ID": "91e5d811-44b4-4fa5-bfd4-ed7245e5e8d1",
          "X-Request-ID": "79e41a5f-f180-4c7a-b2d9-393086ae20a1",
          "X-Session-ID": "b6874da0-bf06-410b-a150-fd5f9164a0b2",
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
          "Accept": "text/event-stream"
        },
        responseType: ResponseType.stream,
      ),
    );

    var messageId = context.last.id + 1;
    StreamTransformer<Uint8List, List<int>> unit8Transformer =
        StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(List<int>.from(data));
      },
    );

    rs.data?.stream
        .transform(unit8Transformer)
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen(
      (event) {
        if (event.contains("[DONE]") ||
            !event.replaceFirst("data: ", "").trim().startsWith("{")) {
          return;
        }

        var content =
            jsonDecode(event.replaceFirst("data: ", "").trim())["choices"][0]
                ["delta"]["content"] as String;

        onFetch(
          Message(
            id: messageId,
            text: content,
            sentByUser: false,
          ),
        );
      },
    );
  }
}
