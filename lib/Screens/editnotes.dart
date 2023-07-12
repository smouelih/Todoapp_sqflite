import 'package:flutter/material.dart';
import 'package:tododata/Screens/HomeScreen.dart';
import 'package:tododata/sqldb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const EditNotes({
    super.key,
    this.note,
    this.title,
    this.color,
    this.id,
  });

  @override
  State<EditNotes> createState() => EditNotesState();
}

class EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
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
                      child: Text('Edit note'),
                      onPressed: () async {
                        int response = await sqlDb.updateData(
                            'UPDATE notes SET note = "${note.text}", title = "${title.text}", color = "${color.text}" WHERE id = ${widget.id}');
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
