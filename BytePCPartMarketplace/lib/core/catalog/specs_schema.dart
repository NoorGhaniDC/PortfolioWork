/// Defines the spec fields for each part category.
/// Used for display formatting and validation.
class SpecsSchema {
  static const Map<String, List<SpecField>> schema = {
    'CPU': [
      SpecField('cores',           'Cores',           SpecFieldType.integer),
      SpecField('threads',         'Threads',         SpecFieldType.integer),
      SpecField('base_clock_ghz',  'Base Clock',      SpecFieldType.ghz),
      SpecField('boost_clock_ghz', 'Boost Clock',     SpecFieldType.ghz),
      SpecField('tdp_watts',       'TDP',             SpecFieldType.watts),
      SpecField('socket',          'Socket',          SpecFieldType.text),
      SpecField('architecture',    'Architecture',    SpecFieldType.text),
    ],
    'GPU': [
      SpecField('vram_gb',         'VRAM',            SpecFieldType.gb),
      SpecField('vram_type',       'VRAM Type',       SpecFieldType.text),
      SpecField('base_clock_mhz',  'Base Clock',      SpecFieldType.mhz),
      SpecField('boost_clock_mhz', 'Boost Clock',     SpecFieldType.mhz),
      SpecField('tdp_watts',       'TDP',             SpecFieldType.watts),
      SpecField('slot_width',      'Slot Width',      SpecFieldType.text),
      SpecField('architecture',    'Architecture',    SpecFieldType.text),
      SpecField('connector',       'Power Connector', SpecFieldType.text),
    ],
    'PSU': [
      SpecField('wattage',           'Wattage',          SpecFieldType.watts),
      SpecField('efficiency_rating', 'Efficiency',       SpecFieldType.text),
      SpecField('modular',           'Modular',          SpecFieldType.text),
      SpecField('form_factor',       'Form Factor',      SpecFieldType.text),
      SpecField('fan_size_mm',       'Fan Size',         SpecFieldType.mm),
      SpecField('pcie5_connector',   'PCIe 5.0 Connector', SpecFieldType.boolean),
    ],
    'Motherboard': [
      SpecField('socket',            'Socket',           SpecFieldType.text),
      SpecField('chipset',           'Chipset',          SpecFieldType.text),
      SpecField('form_factor',       'Form Factor',      SpecFieldType.text),
      SpecField('memory_slots',      'Memory Slots',     SpecFieldType.integer),
      SpecField('max_memory_gb',     'Max Memory',       SpecFieldType.gb),
      SpecField('memory_type',       'Memory Type',      SpecFieldType.text),
      SpecField('pcie_slots',        'PCIe Slots',       SpecFieldType.integer),
      SpecField('m2_slots',          'M.2 Slots',        SpecFieldType.integer),
      SpecField('usb_ports',         'USB Ports',        SpecFieldType.text),
    ],
    'Case': [
      SpecField('form_factor_support',      'Supported Form Factors', SpecFieldType.text),
      SpecField('case_type',                'Case Type',              SpecFieldType.text),
      SpecField('max_gpu_length_mm',        'Max GPU Length',         SpecFieldType.mm),
      SpecField('max_cpu_cooler_height_mm', 'Max CPU Cooler Height',  SpecFieldType.mm),
      SpecField('drive_bays_35',            '3.5" Drive Bays',        SpecFieldType.integer),
      SpecField('drive_bays_25',            '2.5" Drive Bays',        SpecFieldType.integer),
      SpecField('included_fans',            'Included Fans',          SpecFieldType.text),
      SpecField('usb_front_panel',          'Front Panel USB',        SpecFieldType.text),
      SpecField('side_panel',               'Side Panel',             SpecFieldType.text),
    ],
    'Storage': [
      SpecField('capacity_gb',     'Capacity',         SpecFieldType.gb),
      SpecField('type',            'Type',             SpecFieldType.text),
      SpecField('interface',       'Interface',        SpecFieldType.text),
      SpecField('form_factor',     'Form Factor',      SpecFieldType.text),
      SpecField('read_speed_mbs',  'Read Speed',       SpecFieldType.mbs),
      SpecField('write_speed_mbs', 'Write Speed',      SpecFieldType.mbs),
      SpecField('tbw',             'Endurance (TBW)',  SpecFieldType.tbw),
      SpecField('nand_type',       'NAND Type',        SpecFieldType.text),
    ],
    'Monitor': [
      SpecField('screen_size_inch',  'Screen Size',      SpecFieldType.inch),
      SpecField('resolution',        'Resolution',       SpecFieldType.text),
      SpecField('panel_type',        'Panel Type',       SpecFieldType.text),
      SpecField('refresh_rate_hz',   'Refresh Rate',     SpecFieldType.hz),
      SpecField('response_time_ms',  'Response Time',    SpecFieldType.ms),
      SpecField('hdr',               'HDR',              SpecFieldType.text),
      SpecField('adaptive_sync',     'Adaptive Sync',    SpecFieldType.text),
      SpecField('ports',             'Ports',            SpecFieldType.text),
    ],
    'RAM': [
      SpecField('capacity_gb',     'Capacity',        SpecFieldType.gb),
      SpecField('speed_mhz',       'Speed',           SpecFieldType.mhz),
      SpecField('type',            'Type',            SpecFieldType.text),
      SpecField('cas_latency',     'CAS Latency',     SpecFieldType.text),
      SpecField('voltage',         'Voltage',         SpecFieldType.volts),
      SpecField('modules',         'Modules',         SpecFieldType.text),
      SpecField('ecc',             'ECC',             SpecFieldType.boolean),
    ],
  };

  /// Returns formatted display string for a spec value
  static String formatValue(String category, String key, dynamic value) {
    final fields = schema[category] ?? [];
    final field = fields.cast<SpecField?>().firstWhere(
          (f) => f?.key == key,
      orElse: () => null,
    );
    if (field == null) return '$value';
    return field.type.format(value);
  }
}

class SpecField {
  final String key;
  final String label;
  final SpecFieldType type;

  const SpecField(this.key, this.label, this.type);
}

enum SpecFieldType {
  integer,
  text,
  boolean,
  ghz,
  mhz,
  gb,
  watts,
  volts,
  mm,
  inch,
  hz,
  ms,
  mbs,
  tbw;

  String format(dynamic value) {
    switch (this) {
      case SpecFieldType.ghz:    return '$value GHz';
      case SpecFieldType.mhz:    return '$value MHz';
      case SpecFieldType.gb:     return '$value GB';
      case SpecFieldType.watts:  return '${value}W';
      case SpecFieldType.volts:  return '${value}V';
      case SpecFieldType.mm:     return '${value}mm';
      case SpecFieldType.inch:   return '$value"';
      case SpecFieldType.hz:     return '${value}Hz';
      case SpecFieldType.ms:     return value == 0 ? '<1ms' : '${value}ms';
      case SpecFieldType.mbs:    return '$value MB/s';
      case SpecFieldType.tbw:    return value == 0 ? 'N/A' : '$value TBW';
      case SpecFieldType.boolean: return value == true ? 'Yes' : 'No';
      default:                   return '$value';
    }
  }
}