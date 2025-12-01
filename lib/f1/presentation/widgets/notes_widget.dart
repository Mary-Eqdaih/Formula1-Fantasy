import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/cubit/notes_cubit.dart';
import 'package:formula1_fantasy/f1/data/models/notes_model.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/f1_text_field.dart';
import 'package:provider/provider.dart';

class NotesWidget extends StatelessWidget {
  NotesWidget({super.key, required this.model, this.onDismissed}) {
    titleController.text = model.title;
    contentController.text = model.content;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final NotesModel model;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);
    return Dismissible(
      onDismissed: onDismissed,
      background: Container(
        color: f1Red,
        child: Center(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Dismiss",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),

      key: UniqueKey(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: f1Red.withOpacity(0.3)),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "TitilliumWeb",
                ),
              ),
              SizedBox(height: 12),
              Text(
                model.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "TitilliumWeb",
                  letterSpacing: 1,
                  height: 1.8,
                ),
              ),
            ],
          ),
          trailing: Text(
            model.date,
            style: TextStyle(color: Colors.white, fontFamily: "TitilliumWeb"),
          ),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.80,
                  child: Container(
                    decoration: BoxDecoration(color: darkBg),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          F1TextField(
                            textInputAction: TextInputAction.next,
                            controller: titleController,
                            hint: "Enter race title...",
                            minLines: 1,
                            maxLines: 3,
                          ),
                          SizedBox(height: 20),
                          F1TextField(
                            textInputAction: TextInputAction.done,
                            controller: contentController,
                            hint: "Write detailed race notes...",
                            minLines: 5,
                            maxLines: null,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 65,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: f1Red,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide.none,
                                ),
                              ),
                              onPressed: () {
                                NotesModel updatedNote = NotesModel(
                                  title: titleController.text,
                                  content: contentController.text,
                                  date:
                                      "${DateTime.now().day}/${DateTime.now().month}",
                                  id: model.id,
                                );

                                context.read<NotesCubit>().updateNote(
                                  updatedNote,
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "TitilliumWeb",
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
