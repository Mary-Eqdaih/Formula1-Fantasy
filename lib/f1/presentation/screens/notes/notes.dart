import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/notes_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/notes_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/notes_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
        title: const Text(
          'Race Notes',
          style: TextStyle(color: Colors.white, fontFamily: "TitilliumWeb"),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: f1Red),
            );
          }

          if (state is NotesSuccessState) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'No race notes yet.\nTap + to log your first Grand Prix! 🏎️💨 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NotesWidget(
                  model: state.notes[index],
                  onDismissed: (_) {
                    context.read<NotesCubit>().deleteNote(state.notes[index]);
                  },
                );
              },
            );
          }

          // Handle Error State
          if (state is NotesErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          // Fallback for initial or other states
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNote);
        },
        backgroundColor: f1Red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
