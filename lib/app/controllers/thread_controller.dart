import 'package:dio/dio.dart';
import 'api_controller.dart';

class ThreadController extends APIController {

  Future<Response> getThreads({String? nextPage}) async {
    print('$endPoint/r/FlutterDev/.json?after=$nextPage');
    var response = await Dio().get('$endPoint/r/FlutterDev/.json?after=$nextPage', options: Options( headers: jsonHeaders));
    switch (response.statusCode) {
      case 200:
        return response;
       // return Thread.fromJsonList(response.data['data']['children']);

      default:
        throw APIException('Unknown response', response.data);
    }
  }

}
