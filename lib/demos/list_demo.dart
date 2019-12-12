
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  _pushSaved(BuildContext context) async {
    // P 跳转到下一个页面，并等待回传
    final result = await Navigator.of(context).push(
      new MaterialPageRoute(
        // P 跳转到下一个页面，并传值
        builder: (BuildContext context) => SavedRandomWords(
          saved: _saved,
        ),
      ),
    );
    if (result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('$result'),
        ));
    } else {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('没有任何回传信息'),
        ));
    }
  }
//  int getLength() => _suggestions.length;

  Widget _buildSuggestions(BuildContext context) {
    // 标准的 ListView 构造函数适用于短列表
    // 对于具有大量列表项的长列表，需要用 ListView.builder 构造函数来创建。
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(index, _suggestions[index], context);
      },
    );
  }

  Widget _buildRow(int index, WordPair pair, BuildContext context) {
    final bool alreadySaved = _saved.contains(pair);
    return Dismissible(
      key: Key(pair.asString),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        setState(() {
          _suggestions.removeAt(index);
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
          '${pair.asPascalCase}移除成功',
        )));
      },
      child: ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
          key: Key('items_$index'),
        ),
        trailing: Image.asset(alreadySaved
            ? 'assets/images/turnon.png'
            : 'assets/images/turnoff.png'),
//      trailing: new Icon(
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
          final snackBar = SnackBar(
            content: Text('${alreadySaved ? "移除" : "保存"}成功'),
            action: SnackBarAction(
              label: '撤销',
              onPressed: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.add(pair);
                  } else {
                    _saved.remove(pair);
                  }
                });
              },
            ),
          );
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          Builder(
            builder: (ctx) => new IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  _pushSaved(ctx);
                }),
          )
        ],
      ),
      body: Builder(
        builder: (context) => _buildSuggestions(context),
      ),
    );
  }
}

class SavedRandomWords extends StatelessWidget {
  final Set<WordPair> saved;
  SavedRandomWords({Key key, @required this.saved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = saved.map((WordPair pair) {
      return new ListTile(
        title: new Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SuggestionDetail(),
            // P 跳转时，填入需要传入的值
            // settings: RouteSettings(arguments: pair),
          ));
        },
      );
    });
    final List<Widget> divided =
        ListTile.divideTiles(tiles: tiles, context: context).toList();
    // P 定义WillPopScope，重写back方法，并传值
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop('一共收藏了${divided.length}条信息');
        return false;
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      ),
    );
  }
}

class SuggestionDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // P 使用setting方法接受值, 注意：不是每次跳到此页面时都会有值，所以在使用时要判断
    final WordPair wordPair = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('${wordPair != null ? wordPair.asPascalCase : ''}')),
      body: Builder(
        builder: (context) => Center(
            child: RaisedButton(
          child: Text('回到主页'),
          onPressed: () {
            // P 回到主页的方法
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
            // Navigator.of(context).pushNamed('/');
          },
        )),
      ),
    );
  }
}
