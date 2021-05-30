import 'package:flutter/material.dart';
import 'package:h4h/Comman/ResponseDataClass.dart';
import 'Constants.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

Dio dio = new Dio();

class Services {
  static Future<ResponseDataClass> apiHandler({
    @required apiName,
    body,
  }) async {
    String url = API_URL + "$apiName";
    /*   var header = Options(
      headers: {
        "authorization": "$api_token", // set content-length
      },
    );*/
    var response;
    try {
      print("API CALL");
      print("API URL = " + url);
      if (body == null) {
        response = await dio.post(url);
      } else {
        print("++++++++++++++++++++++++++++++++++++++++++++++++");
        print(body);
        response = await dio.post(url, data: body);
      }

      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            Message: "No Data", IsSuccess: false, Data: "");
        var data = response.data;
        print(data);
        responseData.Message = data["Message"];
        responseData.IsSuccess = data["IsSuccess"];
        responseData.Data = data["Data"];

        return responseData;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
