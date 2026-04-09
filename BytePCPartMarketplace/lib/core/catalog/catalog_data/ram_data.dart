/// Raw RAM catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> ramData = [
  // ── Corsair DDR5 ──
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance DDR5-6000 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 6000, 'type': 'DDR5', 'cas_latency': 'CL30', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance DDR5-5600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 5600, 'type': 'DDR5', 'cas_latency': 'CL36', 'voltage': 1.25, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance DDR5-5200 64GB',
    'specs': {'capacity_gb': 64, 'speed_mhz': 5200, 'type': 'DDR5', 'cas_latency': 'CL40', 'voltage': 1.25, 'modules': '2x32GB', 'ecc': false},
  },
  // ── Corsair DDR4 ──
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance RGB Pro DDR4-3600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 3600, 'type': 'DDR4', 'cas_latency': 'CL18', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance LPX DDR4-3200 16GB',
    'specs': {'capacity_gb': 16, 'speed_mhz': 3200, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x8GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Corsair', 'model': 'Vengeance LPX DDR4-3200 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 3200, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  // ── G.Skill DDR5 ──
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Trident Z5 DDR5-6400 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 6400, 'type': 'DDR5', 'cas_latency': 'CL32', 'voltage': 1.4, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Trident Z5 RGB DDR5-6000 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 6000, 'type': 'DDR5', 'cas_latency': 'CL30', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Ripjaws S5 DDR5-5600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 5600, 'type': 'DDR5', 'cas_latency': 'CL28', 'voltage': 1.25, 'modules': '2x16GB', 'ecc': false},
  },
  // ── G.Skill DDR4 ──
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Trident Z Neo DDR4-3600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 3600, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Ripjaws V DDR4-3200 16GB',
    'specs': {'capacity_gb': 16, 'speed_mhz': 3200, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x8GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'G.Skill', 'model': 'Ripjaws V DDR4-3600 64GB',
    'specs': {'capacity_gb': 64, 'speed_mhz': 3600, 'type': 'DDR4', 'cas_latency': 'CL18', 'voltage': 1.35, 'modules': '2x32GB', 'ecc': false},
  },
  // ── Kingston DDR5 ──
  {
    'category': 'RAM', 'manufacturer': 'Kingston', 'model': 'Fury Beast DDR5-5200 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 5200, 'type': 'DDR5', 'cas_latency': 'CL40', 'voltage': 1.25, 'modules': '2x16GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Kingston', 'model': 'Fury Beast DDR5-6000 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 6000, 'type': 'DDR5', 'cas_latency': 'CL36', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  // ── Kingston DDR4 ──
  {
    'category': 'RAM', 'manufacturer': 'Kingston', 'model': 'Fury Beast DDR4-3200 16GB',
    'specs': {'capacity_gb': 16, 'speed_mhz': 3200, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x8GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Kingston', 'model': 'Fury Beast DDR4-3600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 3600, 'type': 'DDR4', 'cas_latency': 'CL17', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
  // ── Crucial DDR5 ──
  {
    'category': 'RAM', 'manufacturer': 'Crucial', 'model': 'Pro DDR5-5600 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 5600, 'type': 'DDR5', 'cas_latency': 'CL46', 'voltage': 1.1, 'modules': '2x16GB', 'ecc': false},
  },
  // ── Crucial DDR4 ──
  {
    'category': 'RAM', 'manufacturer': 'Crucial', 'model': 'Ballistix DDR4-3600 16GB',
    'specs': {'capacity_gb': 16, 'speed_mhz': 3600, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x8GB', 'ecc': false},
  },
  {
    'category': 'RAM', 'manufacturer': 'Crucial', 'model': 'Ballistix DDR4-3200 32GB',
    'specs': {'capacity_gb': 32, 'speed_mhz': 3200, 'type': 'DDR4', 'cas_latency': 'CL16', 'voltage': 1.35, 'modules': '2x16GB', 'ecc': false},
  },
];