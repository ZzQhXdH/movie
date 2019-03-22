import 'package:flutter/cupertino.dart';


class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MovieState();
  }
}

class MovieState extends State<MoviePage> {

  final movieController = new TextEditingController();
  List<Map<String, dynamic>> queryResults;

  void query() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _buildItem(BuildContext context, int index) {
    return new _Item(content: queryResults[index]);
  }

  void onBlankTap() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  int _itemCount() => queryResults == null ? 0 : queryResults.length;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CupertinoPageScaffold(
      child: new SafeArea(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    child: new CupertinoTextField(
                      controller: movieController,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      textAlign: TextAlign.center,
                      placeholder: '请输入要查询的电影名称',
                      prefix: new Icon(CupertinoIcons.mic_solid),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  ),
                  flex: 4,
                ),
                new Expanded(
                  child: new CupertinoButton(
                    child: Text('查询'),
                    onPressed: query,
                  ),
                ),
              ],
            ),
            new Expanded(
              flex: 1,
              child: new GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onBlankTap,
                child: new ListView.builder(
                  itemBuilder: _buildItem,
                  itemCount: _itemCount(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {

  final Map<String, dynamic> content;

  _Item({@required this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: CupertinoColors.inactiveGray,
            offset: Offset(1, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: new Column(
        children: <Widget>[
          new Text('1'),
        ],
      ),
    );
  }
}
