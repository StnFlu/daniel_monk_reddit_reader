import 'package:daniel_monk_reddit_reader/app/models/thread.dart';
import 'package:flutter_test/flutter_test.dart';


const fakeThread = {
  "kind": "t3",
  "data": {
    "selftext": "selftext test",
    "title": "test title",
    "name": "t3_yvas2d",
    "author": "test author",
    "ups": 2,
    "downs": 0,
    "score": 2,
    "link_flair_text": "test flair",
    "num_comments": 3,
    "permalink": "/r/FlutterDev/comments/yvas2d/app_feedback_thread_november_14_2022/",
    "url": "https://www.reddit.com/r/FlutterDev/comments/yvas2d/app_feedback_thread_november_14_2022/",
    "created_utc": 1668456012,
  }
};

void main() {
  test('Test Thread', ()  {
     final thread = Thread.fromJson(fakeThread);
     expect(thread.title, 'test title');
     expect(thread.selfText, 'selftext test');
     expect(thread.name, 't3_yvas2d');
     expect(thread.author, 'test author');
     expect(thread.ups, 2);
     expect(thread.downs, 0);
     expect(thread.score, 2);
     expect(thread.numOfComments, 3);
     expect(thread.permalink, '/r/FlutterDev/comments/yvas2d/app_feedback_thread_november_14_2022/');
     expect(thread.url, 'https://www.reddit.com/r/FlutterDev/comments/yvas2d/app_feedback_thread_november_14_2022/');
     expect(thread.createdUTC, DateTime.fromMillisecondsSinceEpoch((1668456012 * 1000).toInt(), isUtc: true));
  });
}
