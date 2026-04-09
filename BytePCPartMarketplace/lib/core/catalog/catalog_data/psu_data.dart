/// Raw PSU catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> psuData = [
  // ── Corsair ──
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'HX1500i 1500W Platinum',
    'specs': {'wattage': 1500, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'HX1200i 1200W Platinum',
    'specs': {'wattage': 1200, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'HX1000i 1000W Platinum',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'RM1000x 1000W Gold',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'RM850x 850W Gold',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'RM750x 750W Gold',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'RM650x 650W Gold',
    'specs': {'wattage': 650, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'Corsair', 'model': 'CX750F RGB 750W Bronze',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Bronze', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },

  // ── EVGA ──
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 1600 T2 1600W Titanium',
    'specs': {'wattage': 1600, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 1000 G6 1000W Gold',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 850 G6 850W Gold',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 750 G6 750W Gold',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 650 G6 650W Gold',
    'specs': {'wattage': 650, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'EVGA', 'model': 'SuperNOVA 850 P2 850W Platinum',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': false},
  },

  // ── Thermaltake ──
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Toughpower GF3 1350W Gold',
    'specs': {'wattage': 1350, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Toughpower GF3 1050W Gold',
    'specs': {'wattage': 1050, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Toughpower GF3 850W Gold',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Toughpower GF3 750W Gold',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Toughpower PF3 1050W Platinum',
    'specs': {'wattage': 1050, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 140, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Thermaltake', 'model': 'Smart BM3 650W Bronze',
    'specs': {'wattage': 650, 'efficiency_rating': '80+ Bronze', 'modular': 'Semi Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },

  // ── Seasonic ──
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'PRIME TX-1600 1600W Titanium',
    'specs': {'wattage': 1600, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'PRIME TX-1300 1300W Titanium',
    'specs': {'wattage': 1300, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'PRIME TX-1000 1000W Titanium',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'FOCUS GX-1000 1000W Gold',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'FOCUS GX-850 850W Gold',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'FOCUS GX-750 750W Gold',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'Seasonic', 'model': 'FOCUS GX-650 650W Gold',
    'specs': {'wattage': 650, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },

  // ── be quiet! ──
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Dark Power 13 1000W Titanium',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Dark Power 13 850W Titanium',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Titanium', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Straight Power 12 1000W Platinum',
    'specs': {'wattage': 1000, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Straight Power 12 850W Platinum',
    'specs': {'wattage': 850, 'efficiency_rating': '80+ Platinum', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 135, 'pcie5_connector': true},
  },
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Pure Power 12 M 750W Gold',
    'specs': {'wattage': 750, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },
  {
    'category': 'PSU', 'manufacturer': 'be quiet!', 'model': 'Pure Power 12 M 650W Gold',
    'specs': {'wattage': 650, 'efficiency_rating': '80+ Gold', 'modular': 'Fully Modular', 'form_factor': 'ATX', 'fan_size_mm': 120, 'pcie5_connector': false},
  },
];