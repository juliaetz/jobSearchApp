import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'data_read.dart';

class JobRepository {
  Future<List<Job>> loadAndSort() async {
    // 1) Load CSV text
    final rawCsv = await rootBundle.loadString('data/Software Engineer Salaries.csv');

    // 2) Parse into rows
    final table = const CsvToListConverter().convert(rawCsv, eol: '\n');

    // 3) Extract header & rows
    final header = table.first.map((c) => c.toString()).toList();
    final rows   = table.skip(1);

    // 4) Map → Job, skipping bad rows
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

    // 5) Sort by average salary, descending
    jobs.sort((a, b) => b.avgSalary.compareTo(a.avgSalary));
    return jobs;
  }
}
