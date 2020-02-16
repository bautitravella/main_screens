import 'package:flutter/material.dart';
import 'package:flutterui/auth.dart';
import 'package:provider/provider.dart';



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
              final auth = Provider.of<BaseAuth>(context,listen: false);
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


class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}
