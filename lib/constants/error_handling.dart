import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mytt_front/constants/utils.dart';

void httpErrorHandle({required http.Response response, required BuildContext context, required VoidCallback onSuccess}) {
  switch(response.statusCode){
    case 200: 
      onSuccess();
      break;
    default:
      showSnackBar(context, response.body);
  }
}