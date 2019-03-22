import 'package:flutter/cupertino.dart';
import 'MenuBean.dart';

class MenuStepPage extends StatelessWidget {

  final Menu menu;

  MenuStepPage({@required this.menu});

  Widget _item(BuildContext context, int index) {
    return new Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          new Expanded(
            child: ClipRRect(
              child: Image.network(menu.steps[index].imageUrl),
              borderRadius: BorderRadius.circular(10),
            ),
            flex: 2,
          ),
          new Expanded(
            child: new Padding(
              child: new Text(menu.steps[index].step),
              padding: EdgeInsets.all(10),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CupertinoApp(
      home: new CupertinoPageScaffold(
        navigationBar: new CupertinoNavigationBar(
          middle: new Text('${menu.title}详细做法'),
        ),
        child: new SafeArea(
          child: new ListView.builder(
            itemBuilder: _item,
            itemCount: menu.steps.length,
          ),
        ),
      ),
    );
  }
}


