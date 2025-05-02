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
