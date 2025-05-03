import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../MODEL/data_read.dart';

class JobRepository {
  Future<List<Job>> loadAndSort() async {
    // Load CSV text
    final rawCsv = await rootBundle.loadString('data/Software Engineer Salaries.csv');

    // Parse into rows
    final table = const CsvToListConverter().convert(rawCsv, eol: '\n');

    // Extract header & rows
    final header = table.first.map((c) => c.toString()).toList();
    final rows   = table.skip(1);

    // Map to Job, skipping bad rows
    final jobs = <Job>[];
    for (var row in rows) {
      final map = <String, String>{};
      for (var i = 0; i < header.length; i++) {
        map[header[i]] = row[i].toString();
      }
      try {
        jobs.add(Job.fromMap(map));
      } catch (_) {
        // malformed → skip
      }
    }

    // Sort by average salary, descending
    jobs.sort((a, b) => b.avgSalary.compareTo(a.avgSalary));
    return jobs;
  }
}

class DataJobRepository {
  /// Loads, cleans, and sorts DataJob entries from
  /// data/jobs_in_data.csv, descending by salaryInUsd.
  Future<List<DataJob>> loadAndSort() async {
    // 1. Load the raw CSV from assets
    String rawCsv;
    try {
      rawCsv = await rootBundle.loadString('data/jobs_in_data.csv');
    } on FlutterError catch (e) {
      throw FlutterError('Could not load CSV asset: $e');
    }

    // 2. Parse into a table of rows
    final table = const CsvToListConverter().convert(rawCsv, eol: '\n');

    // 3. Extract header row and data rows
    final header = table.first.map((c) => c.toString()).toList();
    final rows   = table.skip(1);

    // 4. Map each row → DataJob, skipping malformed entries
    final jobs = <DataJob>[];
    for (var row in rows) {
      // build a map<columnName, cellValue>
      final map = <String, String>{};
      for (var i = 0; i < header.length; i++) {
        map[header[i]] = row[i].toString();
      }
      try {
        jobs.add(DataJob.fromMap(map));
      } catch (_) {
        // Skip any row that fails parsing/validation
      }
    }

    // 5. Sort by USD salary descending
    jobs.sort((a, b) => b.salaryInUsd.compareTo(a.salaryInUsd));

    return jobs;
  }
}