// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:flutter/material.dart';

// class DonutPieChart extends StatelessWidget {
//   final List<ChartSeries> seriesList;
//   final bool animate;

//   const DonutPieChart(this.seriesList, {super.key, required this.animate});

//   /// Creates a [PieChart] with sample data and no transition.
//   factory DonutPieChart.withSampleData() {
//     return DonutPieChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return charts.PieChart(seriesList,
//         animate: animate,
//         // Configure the width of the pie slices to 60px. The remaining space in
//         // the chart will be left as a hole in the center.
//         defaultRenderer: charts.ArcRendererConfig(arcWidth: 60));
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<LinearSales, int>> _createSampleData() {
//     final data = [
//       LinearSales(0, 100),
//       LinearSales(1, 75),
//       LinearSales(2, 25),
//       LinearSales(3, 5),
//     ];

//     return [
//       charts.Series<LinearSales, int>(
//         id: 'Sales',
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }
// }

// /// Sample linear data type.
// class LinearSales {
//   final int year;
//   final int sales;

//   LinearSales(this.year, this.sales);
// }
