import 'package:flutter/cupertino.dart';
import 'Movie.dart';
import 'Menu.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new CupertinoApp(
      home: new MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {

  @override
  MainState createState() => new MainState();
}

class MainState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(
          items: <BottomNavigationBarItem> [
            new BottomNavigationBarItem(
              icon: new Icon(CupertinoIcons.home)
            ),
            new BottomNavigationBarItem(
              icon: new Icon(CupertinoIcons.location),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          if (index == 0) {
            return new MoviePage();
          }
          if (index == 1) {
            return new MenuPage();
          }
          return new CupertinoPageScaffold(
            child: new Center(
              child: new Text('${index}'),
            ),
          );
        },
    );
  }
}
