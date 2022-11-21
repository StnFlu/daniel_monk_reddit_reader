import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:dio/dio.dart';
import 'api_controller.dart';

class ThreadController extends APIController {

  Future<List<Thread>> getThreads({String? nextPage}) async {
    var response = await Dio().get('$endPoint/r/FlutterDev/.json?after=$nextPage', options: Options( headers: jsonHeaders));
    switch (response.statusCode) {
      case 200:
        return Thread.fromJsonList(response.data['data']['children']);

      default:
        throw APIException('Unknown response', response.data);
    }
  }

}
