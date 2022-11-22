import 'package:dio/dio.dart';
import 'api_controller.dart';

class ThreadController extends APIController {

  Future<Response> getThreads({String? nextPage}) async {
    var response = await Dio().get('$endPoint/r/FlutterDev/.json?after=$nextPage', options: Options( headers: jsonHeaders));
    switch (response.statusCode) {
      case 200:
        return response;
       // return Thread.fromJsonList(response.data['data']['children']);

      default:
        throw APIException('Unknown response', response.data);
    }
  }

  Future<Response> getThread({required String permalink}) async {
    var response = await Dio().get('$endPoint$permalink.json', options: Options( headers: jsonHeaders));
    switch (response.statusCode) {
      case 200:
        return response;
    // return Thread.fromJsonList(response.data['data']['children']);

      default:
        throw APIException('Unknown response', response.data);
    }
  }

}
