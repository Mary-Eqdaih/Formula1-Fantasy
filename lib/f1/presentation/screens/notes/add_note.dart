import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/cubit/notes_cubit.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/pills_widget.dart';
import 'package:provider/provider.dart';
import 'package:formula1_fantasy/f1/data/models/notes_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  static const darkBg = Color(0xFF0F0F10);
  static const card = Color(0xFF18191A);
  static const f1Red = Color(0xFFE10600);

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var notesCubit = context.read<NotesCubit>();
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkBg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "New Note",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: f1Red.withOpacity(0.20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      letterSpacing: .4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    cursorColor: f1Red,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Mexico GP — Lap 35 strategy switch',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      PillsWidget(
                        icon: Icons.event,
                        text: _prettyDate(DateTime.now()),
                      ),
                      const SizedBox(width: 8),
                      PillsWidget(
                        icon: Icons.note_alt_outlined,
                        text: 'Race Notes',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: f1Red.withOpacity(0.20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      letterSpacing: .4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    cursorColor: f1Red,
                    maxLines: null,
                    minLines: 10,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.35,
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      hintText:
                          'Write your race notes...\n• Pit windows, tyre choices\n• Fuel saving laps\n• Overtakes & incidents\n• Setup changes, radio messages',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // FOOTER BUTTONS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text(
                      'Discard',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      NotesModel note = NotesModel(
                        title: titleController.text,
                        content: contentController.text,
                        date: "${DateTime.now().day}/${DateTime.now().month}",
                      );
                      notesCubit.addNote(note);
                      titleController.clear();
                      contentController.clear();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: f1Red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text(
                      'Add',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  static String _prettyDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}
