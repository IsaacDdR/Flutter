import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: MyStatefulWidget(),
      theme: ThemeData(fontFamily: 'Raleway', primaryColor: Colors.red),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 1;

  //static const TextStyle optionStyle = TextStyle(fontSize: 29, fontWeight: FontWeight.bold);

  List<Widget> _widgetOption = <Widget> [

    Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.search),
          ),
        ],
        centerTitle: true,
        title: Text("Restaurantes"),
        leading: Icon(Icons.menu),
      ),
      body: MyHomePage(),
    ),

    Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.search),
          ),
        ],
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text("Tours"),
      ),
      body: MyHomePage(),
    ),

    Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.search),
          ),
        ],
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Text("Antros")
      ),
      body: MyHomePage0(),
    ),

  ];

  void _onTapped (int index) {
    setState((){
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text("Restaurantes"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            title: Text("Tour"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              title: Text("Antros")
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[799],
        onTap: _onTapped,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context ),
    );
  }


  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('lugares').snapshots(),
      builder: (context, snapshot) {
       if(!snapshot.hasData) return LinearProgressIndicator();

       return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Image(
                fit: BoxFit.cover,
                image: CacheImage(record.thumbnail),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(record.name, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(record.description),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.favorite,
                          size: 25.0,
                          color: Colors.red,
                      ),
                      Text(record.votes.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage0 extends StatefulWidget {
  @override
  _MyHomePageState0 createState() {
    return _MyHomePageState0();
  }
}

class _MyHomePageState0 extends State<MyHomePage0> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context ),
    );
  }


  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('antros').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Image(
                fit: BoxFit.cover,
                image: CacheImage(record.thumbnail),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(record.name, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(record.description),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.favorite,
                        size: 25.0,
                        color: Colors.red,
                      ),
                      Text(record.votes.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Record {

  final String thumbnail;
  final String description;
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['description'] != null),
        assert(map['thumbnail'] != null),

        description = map['description'],
        name = map['name'],
        votes = map['votes'],
        thumbnail = map['thumbnail'];


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}


