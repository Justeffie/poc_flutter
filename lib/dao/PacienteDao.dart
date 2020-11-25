import 'dart:async';

import 'package:flutter_poc/models/Paciente.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PacienteDao {


  final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(path, 'paciente_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pacientes(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, apellido TEXT, dni INTEGER, domicilio TEXT, peso REAL, altura REAL)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  });

  Future<void> insertPaciente(Paciente paciente) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Paciente into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same paciente is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'pacientes',
      paciente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Paciente>> pacientes() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Pacientes.
    final List<Map<String, dynamic>> maps = await db.query('pacientes');

    // Convert the List<Map<String, dynamic> into a List<Paciente>.
    return List.generate(maps.length, (i) {
      return Paciente.fromDB(maps[i]['id'], maps[i]['name'], maps[i]['apellido'],
          maps[i]['dni'], maps[i]['domicilio'], maps[i]['peso'],
          maps[i]['altura']);
    });
  }

  Future<void> updatePaciente(Paciente paciente) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Paciente.
    await db.update(
      'pacientes',
      paciente.toMap(),
      // Ensure that the Paciente has a matching id.
      where: "id = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [paciente.id],
    );
  }

  Future<void> deletePaciente(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Paciente from the database.
    await db.delete(
      'pacientes',
      // Use a `where` clause to delete a specific paciente.
      where: "id = ?",
      // Pass the Paciente's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Paciente from the database.
    await db.delete(
      'pacientes'
    );
  }
}
