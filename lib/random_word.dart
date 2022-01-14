
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState()=> RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomList = <WordPair>[];
  final _savedWord = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder : (context, item) {
          if(item.isOdd) return Divider();

          final index = item ~/ 2;
          if(index >= _randomList.length) {
            _randomList.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomList[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWord.contains(pair);
    return ListTile(title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18),),
    trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border
       , color: alreadySaved ? Colors.red : null,),
    onTap: () {
      setState(() {
        if(alreadySaved) {
          _savedWord.remove(pair);
        } else {
          _savedWord.add(pair);
        }
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Word Gen"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.list),
        onPressed: _pushSaved)
      ],),
      body: _buildList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> titles =
            _savedWord.map((WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16),),
            );
            });

        final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: titles,).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Favs "),
          ),
          body: ListView(children: divided,),
        );
      }
    ));
  }
}

