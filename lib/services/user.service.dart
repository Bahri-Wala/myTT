import 'package:dio/dio.dart';
import 'package:mytt_front/services/dio/dio_service.dart';

class UserService{
  UserService._();

  static Future<dynamic> getUsers(context) async {
    try{
      print("gettin users...");
      var response = await DioService.dio.get('${DioService.url}user');
      print("response: ${response}");
      // if (response.data["error"] != null) {
      //   return response.data["error"];
      // } else {
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      //   User user = User.fromJson(response.data["user"]);
      //   return user;
      // }
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }
}