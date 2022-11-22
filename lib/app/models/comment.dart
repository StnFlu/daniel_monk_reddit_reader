import 'package:equatable/equatable.dart';

import '../controllers/api_controller.dart';

class Comment extends Equatable{
  final String body, author;
  final int score;
  final DateTime createdUTC;
  final List<Comment>? replies;


  const Comment({
    required this.author,
    required this.body,
    required this.score,
    required this.createdUTC,
    this.replies
  });

  static List<Comment> fromJsonList(List list) {
    return list.map((item) => Comment.fromJson(item)).toList();
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    if(json['kind'] != 't1'){
      throw ThingException('Unknown response', 'Wrong Kind');
    }
    json = json['data'];
    return Comment(
      body: json['body'],
      author: json['author'],
      score: json['score'],
      replies: json['replies'] != "" ? Comment.fromJsonList(json['replies']['data']['children']): null,
      createdUTC: DateTime.fromMillisecondsSinceEpoch((json['created_utc'] * 1000).toInt(), isUtc: true)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [body, author];
}
