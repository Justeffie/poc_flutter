import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArchivoDaoDBImpl {
  final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(path, 'archivos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE archivos(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
  });

  Future<void> insertArchivo(String text) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Paciente into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same paciente is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'archivos',
      {'id': null, 'text': text},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateArchivo(int id, String text) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Paciente.
    await db.update(
      'archivos',
      {'id': id, 'text': text},
      // Ensure that the Paciente has a matching id.
      where: "id = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteEnfermedad(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Paciente from the database.
    await db.delete(
      'archivos',
      // Use a `where` clause to delete a specific paciente.
      where: "id = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await database;

    // Remove thetype '_Uint8ArrayView' is not a subtype of type 'String' Paciente from the database.
    await db.delete('archivos');
  }
}
