import 'package:flutter/material.dart';
import 'package:tododata/Screens/editnotes.dart';
import 'package:tododata/sqldb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDB = SqlDb();
  bool isloading = true;

  List notes = [];

  Future readdata() async {
    List<Map> responce = await sqlDB.read(" notes");
    notes.addAll(responce);
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes');
        },
      ),
      body: isloading == true
          ? Center(child: Text('Loading...'))
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                      itemCount: notes.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            title: Text('${notes[i]['title']}'),
                            subtitle: Text('${notes[i]['note']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // int response = await sqlDB.deleteData(
                                    //     'DELETE FROM notes WHERE id = ${notes[i]['id']}  ');
                                    int response = await sqlDB.delete(
                                        'notes', "id = ${notes[i]['id']}");
                                    print('data deleted');
                                    if (response > 0) {
                                      notes.removeWhere((element) =>
                                          element['id'] == notes[i]['id']);
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditNotes(
                                                  note: notes[i]['note'],
                                                  title: notes[i]['title'],
                                                  color: notes[i]['color'],
                                                  id: notes[i]['id'],
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
