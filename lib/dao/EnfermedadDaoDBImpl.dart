import 'dart:async';
import 'package:flutter_poc/models/Enfermedad.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EnfermedadDaoDBImpl {
  final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(path, 'enfermedades.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE enfermedades(code INTEGER PRIMARY KEY AUTOINCREMENT, descripcion TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
  });

  Future<void> insertEnfermedad(Enfermedad enfermedad) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Enfermedad into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same enfermedad is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'enfermedades',
      enfermedad.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Enfermedad>> enfermedades() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Pacientes.
    final List<Map<String, dynamic>> maps = await db.query('enfermedades');

    // Convert the List<Map<String, dynamic> into a List<Enfermedades>.
    return List.generate(maps.length, (i) {
      return Enfermedad.fromDB(maps[i]['code'], maps[i]['descripcion']);
    });
  }

  Future<void> updateEnfermedad(Enfermedad enfermedad) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Paciente.
    await db.update(
      'enfermedades',
      enfermedad.toMap(),
      // Ensure that the Paciente has a matching id.
      where: "code = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [enfermedad.code],
    );
  }

  Future<void> deleteEnfermedad(int code) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Paciente from the database.
    await db.delete(
      'enfermedades',
      // Use a `where` clause to delete a specific paciente.
      where: "code = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [code],
    );
  }

  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await database;

    // Remove thetype '_Uint8ArrayView' is not a subtype of type 'String' Paciente from the database.
    await db.delete('enfermedades');
  }
}
