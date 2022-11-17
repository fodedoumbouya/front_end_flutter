import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/utils/global.dart';
import 'package:http/http.dart' as http;

const String host = "http://152.32.143.204/back_facebook/";

Future<http.Response> postRequest({
  required String path,
  required Map<String, dynamic> body,
}) async {
  var url = "$host$path.php";

  // Map data = {'apikey': '12345678901234567890'};
  //encode Map to JSON
  var b = json.encode(body);

  var response = await http.post(Uri.parse(url),
      // headers: {
      //   "Content-Type": "application/json",
      //   "Access-Control-Allow-Origin": "*",
      //   "Access-Control-Allow-Headers": "*"
      // },
      body: b);
  print("${response.statusCode}");
  print(response.body);
  return response;
}

showToast(
  String msg, {
  Color bgColor = const Color.fromRGBO(0x18, 0x23, 0x3d, 0.8),
  bool bottom = false,
  int duration = 1,
  BuildContext? contextFrom,
}) {
  var context = contextFrom ?? ctxt;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      //error ? Colors.red : Theme.of(context).backgroundColor,

      behavior: SnackBarBehavior.fixed,
      // margin:
      //     EdgeInsets.only(bottom: bottom ? 100 : 400.0, right: 100, left: 100),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color:
                //error ?
                Colors.white
            //    : const Color.fromRGBO(51, 51, 51, 1),
            ),
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

String getOperationID() {
  var bytes = utf8.encode(DateTime.now().timeZoneName +
      DateTime.now().millisecondsSinceEpoch.toString()); // data being hashed

  var digest = sha256.convert(bytes);

  return digest.toString();
}

Dio? dio;
String token = "";

Future globalRequest({
  required String path,
  required Map<String, dynamic> body,
  // required BuildContext context,
  bool isGet = false,
  bool isFile = false,
  String filePath = "",
  bool isProfile = false,
  String params = "",
}) async {
  // if (isFile) {
  //   dio = null;
  // }
  // if (dio == null) {
  BaseOptions options = BaseOptions(
    baseUrl: host,
    contentType: isFile ? "multipart/form-data" : "application/json",
    connectTimeout: 100000,
    receiveTimeout: 100000,
  );
  dio = Dio(options);
  // }

  Map<String, dynamic> httpBody;
  httpBody = Map<String, dynamic>.from(body);
  path = "$path.php";
  print("request: $path,params: $httpBody");
  // Map<String, dynamic> headers = {"Access-Control-Allow-Origin": "*"};
  // (token.isNotEmpty ? {'Authorization': "Bearer " + token} : {});

  Response response;
  try {
    if (isGet) {
      response = await dio!.get(
        path,
        queryParameters: httpBody,
      ); // options: Options(headers: headers)
    } else {
      Object data;
      if (isFile) {
        // bw.BaseWidgetState().getOperationID();
        String fileName = "${getOperationID()}.${filePath.split('.').last}";
        data = FormData.fromMap({
          "file": await MultipartFile.fromFile(filePath, filename: fileName),
          "isProfile": isProfile,
        });
      } else {
        data = httpBody;
      }
      // if (isGet) {
      //   String u = params.isEmpty ? path : "$path?$params";
      //   response = await dio!.get(u, options: Options(headers: headers));
      // } else {
      response = await dio!.post(
        path,
        data: data,
      ); // options: Options(headers: headers)
      // }
      print("Post here:  ${response.data}");
    }
  } catch (e) {
    debugPrint("network error:" + e.toString());
    // if (e is SocketException) {
    showToast("Votre connection n'est stable, veuiller réessayer plutard");
    //  }
    return {};
  }
  // if (response.statusCode != 200) {
  //   showToast('Erreur réseau!');
  //   return {};
  // }
  var result = response.data;
  debugPrint("response:" + result.toString());
  return result;
}
