import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: const [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text("Fetching more posts..."),
          )
        ],
      ),
    );
  }
}
