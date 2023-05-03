// ignore_for_file: avoid_print
import 'dart:io';

const mainLcov = 'coverage/main.lcov.info';
const prLcov = 'coverage/lcov.info';
const badgeTemplate = 'coverage/badge-template.svg';
const badge = 'coverage/badge.svg';
const coverageErrorThresholdPercentage = 0.5;

Future<void> main(List<String> args) async {
  switch (args[0]) {
    case 'pr_branch_percentage':
      print((await _calculateCoveragePercentage(prLcov)).toStringAsFixed(2));
      return;
    default:
      return;
  }
}

Future<double> _calculateCoveragePercentage(String lcovFile) async {
  final lines = await File(lcovFile).readAsLines();
  final coverage = lines.fold<List<int>>([0, 0], (data, line) {
    var testedLines = data[0];
    var totalLines = data[1];
    if (line.startsWith('DA:')) {
      totalLines++;
      if (!line.endsWith(',0')) {
        testedLines++;
      }
    }
    return [testedLines, totalLines];
  });
  final testedLines = coverage[0];
  final totalLines = coverage[1];
  final percent = testedLines / totalLines * 100;
  return percent;
}
