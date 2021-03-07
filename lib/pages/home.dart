import 'package:flutter/material.dart';
import '../server.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> _notesData;
  List<String> _notes = [];

  void getNotesData() async {
    _notesData = await fetchData();
    if (_notesData != null) {
      _notesData.forEach((element) {
        _notes.add(element["newNote"]);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNotesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jot Notes'),
      ),
      body: Container(
        child: displayNotes(),
        color: Colors.green,
      ),
      floatingActionButton: btnRefresh(),
    );
  }

  Widget btnRefresh() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/');
      },
      tooltip: 'Refresh',
      child: Icon(Icons.refresh),
    );
  }
  // Widget btnAddNotes() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       showAddNotesDialog(context).then((value) {
  //         if (value != null) {
  //           //database update not yet implemented
  //           //
  //           _notes.add(value);
  //           setState(() {});
  //         }
  //       });
  //     },
  //     child: Icon(Icons.add),
  //   );
  // }

  // Future<String> showAddNotesDialog(BuildContext context) {
  //   TextEditingController customController = TextEditingController();
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Write notes here"),
  //         content: TextField(
  //           controller: customController,
  //         ),
  //         actions: <Widget>[
  //           MaterialButton(
  //             elevation: 5.0,
  //             child: Text("Add"),
  //             color: Colors.green,
  //             onPressed: () {
  //               Navigator.of(context).pop(customController.text.toString());
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget bgDelete() {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.delete),
    );
  }

  showSnackBar(context, text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Widget displayNotes() {
    return ListView.builder(
      itemCount: _notes.length,
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            child: ListTile(title: Text(_notes[index])),
          ),
          background: bgDelete(),
          onDismissed: (direction) {
            showSnackBar(context, "Note Deleted");
            _notes.removeAt(index);
            //database delete not yet implemented
            setState(() {});
          },
        );
      },
    );
  }
}
