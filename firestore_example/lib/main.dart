import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firestore Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
            child: StreamBuilder(
                stream:
                    Firestore.instance.collection('testCollection').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Text('Loading...');
                  else if (snapshot.data.documents.length > 0)
                    return ListView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => Dismissible(
                          // NOTE: key is very important for Dismissable widget
                          onDismissed: (direction) {
                            _deleteDocument(snapshot.data.documents[index]);
                          },
                          background: Container(
                            color: Colors.redAccent,
                            alignment: Alignment(-0.8, 0.0),
                            child: const Text(
                              "dimissing",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          key: Key(snapshot.data.documents[index]['id']),
                          child: Card(
                              child: ListTile(
                                  title: Text(snapshot.data.documents[index]
                                      ['name'])))),
                    );
                  else
                    return Text(
                      "No documents in the db",
                      style: TextStyle(color: Colors.redAccent),
                    );
                })));
  }

  // Deleting single document from firestore by transaction
  _deleteDocument(document) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      //
      DocumentSnapshot nameSnapshot = await transaction.get(document.reference);
      //
      if (nameSnapshot.exists) {
        print("Removing...");
        // In transaction: you must call delete from transaction object
        await transaction.delete(document.reference);
      }
    });
  }
}
