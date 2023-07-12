import 'package:flutter/material.dart';
import 'package:tododata/Screens/HomeScreen.dart';
import 'package:tododata/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: InputDecoration(
                        hintText: 'note',
                      ),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                        hintText: 'title',
                      ),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: InputDecoration(
                        hintText: 'color',
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('add note'),
                      onPressed: () async {
                        int response = await sqlDb.insertData(
                            'INSERT INTO notes (note, title, color) VALUES ("${note.text}", "${title.text}", "${color.text}")');
                        print('data inserted');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
