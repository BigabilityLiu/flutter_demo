

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

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map(
                  (WordPair pair) {
                return new ListTile(
                  title: new Text(pair.asPascalCase,
                      style: _biggerFont),
                );
              }
          );
          final List<Widget> divided = ListTile.divideTiles(tiles: tiles,context: context).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
//  int getLength() => _suggestions.length;

  Widget _buildSuggestions(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index], context);
      },
    );
  }

  Widget _buildRow(WordPair pair,BuildContext context) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Image.asset(alreadySaved ? 'assets/images/turnon.png' : 'assets/images/turnoff.png'),
//      trailing: new Icon(
//        alreadySaved ? Icons.favorite : Icons.favorite_border,
//        color: alreadySaved ? Colors.red : null,
//      ),
      onTap: (){
        setState(() {
          if (alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
        
        Scaffold.of(context).removeCurrentSnackBar();
         final snackBar = SnackBar(
          content: Text('${alreadySaved ? "移除" : "保存"}成功'),
          action: SnackBarAction(
            label: '撤销',
            onPressed: () {
              setState(() {
                if (alreadySaved){
                  _saved.add(pair);
                }else{
                  _saved.remove(pair);
                }
              });
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: Builder(
        builder: (context) => _buildSuggestions(context),
      ) ,
    );
  }
}