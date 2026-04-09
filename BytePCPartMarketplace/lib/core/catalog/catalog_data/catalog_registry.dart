import 'cpu_data.dart';
import 'gpu_data.dart';
import 'ram_data.dart';
import 'psu_data.dart';
import 'motherboard_data.dart';
import 'case_data.dart';
import 'monitor_data.dart';
import 'storage_data.dart';

/// Single registry combining all category data.
/// To add a new category:
///   1. Create a new data file (e.g. cooling_data.dart)
///   2. Import it here and add it to allParts below
const List<Map<String, dynamic>> allParts = [
  ...cpuData,
  ...gpuData,
  ...ramData,
  ...psuData,
  ...motherboardData,
  ...caseData,
  ...monitorData,
  ...storageData,
];