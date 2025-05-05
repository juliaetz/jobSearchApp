import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../MODEL/data_read.dart';

class JobRepository {
  Future<List<Job>> loadAndSort() async {
    // 1) Load raw CSV
    final rawCsv = await rootBundle.loadString('data/Software Engineer Salaries.csv');
    if (rawCsv.trim().isEmpty) {
      throw FormatException('CSV is empty');
    }

    // 2) Parse into a table
    final table = const CsvToListConverter().convert(rawCsv, eol: '\n');
    if (table.isEmpty) {
      throw FormatException('No rows in CSV');
    }

    // 3) Normalize header names
    final header = table.first.map((c) => c.toString().trim()).toList();

    // 4) Map rows → Job
    final jobs = <Job>[];
    for (var row in table.skip(1)) {
      final map = <String, String>{};
      for (var i = 0; i < header.length && i < row.length; i++) {
        map[header[i]] = row[i].toString().trim();
      }
      try {
        jobs.add(Job.fromMap(map));
      } catch (_) {
        // skip malformed rows
      }
    }

    // 5) Sort by salary descending
    jobs.sort((a, b) => b.avgSalary.compareTo(a.avgSalary));
    return jobs;
  }
}


class DataJobRepository {
  /// Loads, cleans, and sorts DataJob entries from
  /// data/jobs_in_data.csv, descending by salaryInUsd.
  Future<List<DataJob>> loadAndSort() async {
    // 1) Load raw CSV
    final rawCsv = await rootBundle.loadString('data/jobs_in_data.csv');
    if (rawCsv.trim().isEmpty) {
      throw FormatException('CSV is empty');
    }

    // 2) Parse into rows
    final table = const CsvToListConverter().convert(rawCsv, eol: '\n');
    if (table.isEmpty) {
      throw FormatException('No rows found in CSV');
    }

    // 3) Extract & normalize header
    final header = table.first.map((c) => c.toString().trim()).toList();

    // 4) Map rows → DataJob
    final jobs = <DataJob>[];
    for (var row in table.skip(1)) {
      final map = <String, String>{};
      for (var i = 0; i < header.length && i < row.length; i++) {
        map[header[i]] = row[i].toString().trim();
      }
      try {
        jobs.add(DataJob.fromMap(map));
      } catch (_) {
        // skip malformed rows
      }
    }

    // 5) Sort by USD salary descending
    jobs.sort((a, b) => b.salaryInUsd.compareTo(a.salaryInUsd));
    return jobs;
  }
}