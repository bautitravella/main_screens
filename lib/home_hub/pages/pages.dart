import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:flutterui/provider.dart';


class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: RaisedButton(
          child: Text("SIGN OUT"),
          onPressed: () async {
            try {
              Auth auth = Provider
                  .of(context)
                  .auth;
              await auth.signOut();
            }catch(e) {
              print(e.message);
            }
          },
        ),
      ),
    );
  }
}

class PastTripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}