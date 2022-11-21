import '../controllers/api_controller.dart';

class Thread {
  String name, title, author, permalink;
  int ups, downs, numOfComments;
  String? url, selfText, linkFlairText;
  DateTime createdUTC;


  Thread({
    required this.name,
    required this.title,
    required this.author,
    required this.permalink,
    required this.ups,
    required this.downs,
    required this.numOfComments,
    this.url,
    this.selfText,
    this.linkFlairText,
    required this.createdUTC
  });

  static List<Thread> fromJsonList(List list) {
    return list.map((item) => Thread.fromJson(item)).toList();
  }

  factory Thread.fromJson(Map<String, dynamic> json) {
    if(json['kind'] != 't3'){
      throw ThingException('Unknown response', 'Wrong Kind');
    }
    json = json['data'];
    return Thread(
      name: json['name'],
      title: json['title'],
      author: json['author'],
      permalink: json['permalink'],
      ups: json['ups'],
      downs: json['downs'],
      numOfComments: json['num_comments'],
      url: json['url'],
      selfText: json['selftext'],
      linkFlairText: json['link_flair_text'],
      createdUTC: DateTime.fromMillisecondsSinceEpoch((json['created_utc'] * 1000).toInt(), isUtc: true)
    );
  }

  @override
  String toString() {
    return "Model~Thread :: title: $title, created_at: $createdUTC";
  }
  @override
  bool operator ==(Object other) => other is Thread && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
