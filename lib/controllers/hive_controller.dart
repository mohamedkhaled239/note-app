import 'package:hive/hive.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_adapter.dart';

class HiveController {
  static final HiveController _singleton = HiveController._internal();
  factory HiveController() => _singleton;
  HiveController._internal();

  void init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
    // await Hive.openBox('notesBox'); // <Note>
  }

  // if box is oppened,  connect it , else open it

  Future<Box<Note>> getBox() async {
    if (!Hive.isBoxOpen("notesBox")) {
      return Hive.openBox("notesBox");
    }
    return Hive.box("notesBox");
  }

  void delete(idx) async {
    final box = await getBox();
    await box.deleteAt(idx);
  }

  void add(Note note) async {
    final box = await getBox();
    await box.add(note);
  }

  void update(Note note) async {
    final box = await getBox();
    await box.putAt(note.id!, note);
  }

  Future<List<Note>> getNotes() async {
    final box = await getBox();
    return box.values.toList();
  }

  void clear() async {
    final box = await getBox();
    await box.clear();
  }
}
