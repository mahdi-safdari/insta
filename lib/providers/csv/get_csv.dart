import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class MyClass {
  Future<List<List<dynamic>>> readCSV() async {
    final String file = await rootBundle.loadString('assets/mycsv.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(file);

    return csvTable;
  }
}
