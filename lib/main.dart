import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final noun = new WordNoun.random();
    final adjective = new WordAdjective.random();
    return MaterialApp(
      title: 'Word Game',
      home: new RandomSentences(),
    );
  }
}

class RandomSentences extends StatefulWidget {
  @override
  createState() => new _RandomSentences();
}

final _sentences = <String>[];
final _funnies = Set<String>();
final _biggerFont = const TextStyle(fontSize: 14.0);

class _RandomSentences extends State<RandomSentences> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final noun = new WordNoun.random();
    final adjective = new WordAdjective.random();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Word Game'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushFunnies)
        ],
      ),
      body: new ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            final index = i ~/ 2;
            if (index >= _sentences.length) {
              _sentences.add(_getSentence());
            }
            return _buildRow(_sentences[index]);
          }),
    );
  }

  void _pushFunnies() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _funnies.map((sentence) {
        return new ListTile(
          title: new Text(sentence, style: _biggerFont),
        );
      });
      final divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Funny Sentences'),
        ),
        body: new ListView(children: divided,padding: EdgeInsets.all(15.0),),
      );
    }));
  }

  Widget _buildRow(String sentence) {
    final isAlreadyExist = _funnies.contains(sentence);
    return new ListTile(
      title: new Text(sentence, style: _biggerFont),
      trailing: new Icon(isAlreadyExist ? Icons.thumb_up : Icons.thumb_down,
          color: isAlreadyExist ? Colors.green : null),
      onTap: () {
        setState(() {
          if (isAlreadyExist)
            _funnies.remove(sentence);
          else
            _funnies.add(sentence);
        });
        // print('sss');
      },
    );
  }
}

String _getSentence() {
  final noun = new WordNoun.random();
  final adjective = new WordAdjective.random();
  return 'Programmer wrote  ${adjective.asCapitalized}'
      'App in Flutter and showed it'
      'of on his ${noun.asCapitalized}';
}
