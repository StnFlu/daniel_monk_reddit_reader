import 'dart:convert';
import 'dart:io';

class APIController {

  String endPoint = "https://ssl.reddit.com/";
  Map<String, String> jsonHeaders = {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.contentTypeHeader: 'application/json'};

}
class APIException implements Exception {
  String cause;
  String body;
  late Map<String, dynamic> jsonBody;

  APIException(this.cause, this.body) {
    try {
      jsonBody = json.decode(body) as Map<String, dynamic>;
    } catch (e) {
      jsonBody = {};
    }
  }

  @override
  String toString() {
    return "APIException :: $cause (${jsonBody.isNotEmpty ? jsonBody : body})";
  }
}

class ThingException implements Exception {
  String cause;
  String body;
  late Map<String, dynamic> jsonBody;

  ThingException(this.cause, this.body) {
    try {
      jsonBody = json.decode(body) as Map<String, dynamic>;
    } catch (e) {
      jsonBody = {};
    }
  }

  @override
  String toString() {
    return "ThingException :: $cause (${jsonBody.isNotEmpty ? jsonBody : body})";
  }
}
