import 'package:flutter/cupertino.dart';
import 'http.dart';
import 'MenuBean.dart';
import 'MenuStepPage.dart';

final MenuApiKey = '03f524ca67715bfbbe82ab2c0d360fe5';
final MenuApiAddr = 'http://apis.juhe.cn/cook/query.php';

String _getUrlWithName(String name) {
  return '${MenuApiAddr}?menu=${name}&key=${MenuApiKey}';
}

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MenuState();
  }
}

class MenuState extends State<MenuPage> {
  final menuController = new TextEditingController();
  List<Menu> _queryResults;
  bool _isLoading = false;

  _showDialog(String title, String content) async {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new CupertinoButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<List<Menu>> _queryOfName(String name) async {
    final ret = await HttpRequest.get(_getUrlWithName(name));
    final result = ret['result']['data'];
    return Menu.withJsons(result);
  }

  _imagesWithIndex(int index) => _queryResults[index].imageUrl;
  _nameWithIndex(int index) => _queryResults[index].title;
  _ingredientsWithIndex(int index) => _queryResults[index].ingredients;
  _burdenWithIndex(int index) => _queryResults[index].burden;

  _loadState(bool f) {
    setState(() {
      _isLoading = f;
    });
  }

  _query() {

    final text = menuController.text;
    if (text.length <= 0) {
      _showDialog('提示', '请输入菜名');
      return;
    }
    _loadState(true);
    FocusScope.of(context).requestFocus(FocusNode());
    _queryOfName(text).then(_result).catchError((e) {
      _loadState(false);
      _showDialog('错误', '无法查询');
    });
  }

  _result(List<Menu> map) {
    setState(() {
      print(map);
      _isLoading = false;
      _queryResults = map;
    });
  }

  _onTapItem(int index) {
    print('选择了第${index}');

    Navigator.push<Object>(context,
        new CupertinoPageRoute(
            builder: (context) => new MenuStepPage( menu: _queryResults[index], ))
    );
  }

  _onTapBink() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget _itemsAndWait() {
    if (_isLoading) {
      return new CupertinoActivityIndicator(
        radius: 60,
      );
    } else {
      return new ListView.builder(
        itemBuilder: _buildItem,
        itemCount: _itemCount(),
      );
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () => {_onTapItem(index)},
      child: new Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              color: CupertinoColors.lightBackgroundGray, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: CupertinoColors.white,
            )
          ],
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 2,
              child: new ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: new Image.network(
                  _imagesWithIndex(index),
                ),
              ),
            ),
            new Expanded(
              flex: 3,
              child: new Padding(
                padding: EdgeInsets.all(5),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('名称: ${_nameWithIndex(index)}'),
                    new Text('配料: ${_ingredientsWithIndex(index)}'),
                    new Text('材料: ${_burdenWithIndex(index)}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _itemCount() {
    return _queryResults == null ? 0 : _queryResults.length;
  }

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
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: CupertinoTextField(
                      controller: menuController,
                      prefix: new Icon(CupertinoIcons.add),
                      placeholder: '请输入菜名',
                      clearButtonMode: OverlayVisibilityMode.editing,
                    ),
                  ),
                ),
                new CupertinoButton(
                  child: new Text('查询菜谱'),
                  onPressed: _query,
                ),
              ],
            ),
            new Expanded(
              flex: 1,
              child: new GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _onTapBink,
                child: _itemsAndWait(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
