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
    final result = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return new ListTile(
              title: new Text(pair.asPascalCase, style: _biggerFont),
            );
          });
          final List<Widget> divided =
              ListTile.divideTiles(tiles: tiles, context: context).toList();
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
        },
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
