/// Raw Storage catalog data.
/// Covers HDD, SATA SSD, NVMe M.2 from Kingston, Samsung, and Western Digital.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> storageData = [

  // ════════════════════════════════════════
  // SAMSUNG — NVMe M.2
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '990 Pro 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7450, 'write_speed_mbs': 6900, 'tbw': 1200, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '990 Pro 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7450, 'write_speed_mbs': 6900, 'tbw': 600, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '980 Pro 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7000, 'write_speed_mbs': 5100, 'tbw': 1200, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '980 Pro 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7000, 'write_speed_mbs': 5000, 'tbw': 600, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '970 Evo Plus 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 3.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 3300, 'tbw': 1200, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '970 Evo Plus 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 3.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 3300, 'tbw': 600, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '970 Evo Plus 500GB NVMe M.2',
    'specs': {'capacity_gb': 500, 'type': 'NVMe M.2', 'interface': 'PCIe 3.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 3200, 'tbw': 300, 'nand_type': 'V-NAND MLC'},
  },

  // ════════════════════════════════════════
  // SAMSUNG — SATA SSD
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '870 Evo 4TB SATA SSD',
    'specs': {'capacity_gb': 4000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 2400, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '870 Evo 2TB SATA SSD',
    'specs': {'capacity_gb': 2000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 1200, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '870 Evo 1TB SATA SSD',
    'specs': {'capacity_gb': 1000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 600, 'nand_type': 'V-NAND MLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '870 QVO 8TB SATA SSD',
    'specs': {'capacity_gb': 8000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 2880, 'nand_type': 'V-NAND QLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Samsung', 'model': '870 QVO 4TB SATA SSD',
    'specs': {'capacity_gb': 4000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 1440, 'nand_type': 'V-NAND QLC'},
  },

  // ════════════════════════════════════════
  // KINGSTON — NVMe M.2
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'KC3000 4TB NVMe M.2',
    'specs': {'capacity_gb': 4000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7000, 'write_speed_mbs': 7000, 'tbw': 3200, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'KC3000 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7000, 'write_speed_mbs': 7000, 'tbw': 1600, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'KC3000 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7000, 'write_speed_mbs': 6000, 'tbw': 800, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'NV2 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 2800, 'tbw': 640, 'nand_type': '3D QLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'NV2 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 2100, 'tbw': 320, 'nand_type': '3D QLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'NV2 500GB NVMe M.2',
    'specs': {'capacity_gb': 500, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 3500, 'write_speed_mbs': 1300, 'tbw': 160, 'nand_type': '3D QLC'},
  },

  // ════════════════════════════════════════
  // KINGSTON — SATA SSD
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'A400 960GB SATA SSD',
    'specs': {'capacity_gb': 960, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 500, 'write_speed_mbs': 450, 'tbw': 300, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'A400 480GB SATA SSD',
    'specs': {'capacity_gb': 480, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 500, 'write_speed_mbs': 450, 'tbw': 160, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'KC600 2TB SATA SSD',
    'specs': {'capacity_gb': 2000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 550, 'write_speed_mbs': 520, 'tbw': 1200, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Kingston', 'model': 'KC600 1TB SATA SSD',
    'specs': {'capacity_gb': 1000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 550, 'write_speed_mbs': 520, 'tbw': 600, 'nand_type': '3D TLC'},
  },

  // ════════════════════════════════════════
  // WESTERN DIGITAL — NVMe M.2
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black SN850X 4TB NVMe M.2',
    'specs': {'capacity_gb': 4000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7300, 'write_speed_mbs': 6600, 'tbw': 2400, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black SN850X 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7300, 'write_speed_mbs': 6600, 'tbw': 1200, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black SN850X 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 7300, 'write_speed_mbs': 6300, 'tbw': 600, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue SN580 2TB NVMe M.2',
    'specs': {'capacity_gb': 2000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 4150, 'write_speed_mbs': 4150, 'tbw': 900, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue SN580 1TB NVMe M.2',
    'specs': {'capacity_gb': 1000, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 4150, 'write_speed_mbs': 4150, 'tbw': 600, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue SN580 500GB NVMe M.2',
    'specs': {'capacity_gb': 500, 'type': 'NVMe M.2', 'interface': 'PCIe 4.0 x4', 'form_factor': 'M.2 2280', 'read_speed_mbs': 4000, 'write_speed_mbs': 3600, 'tbw': 300, 'nand_type': '3D TLC'},
  },

  // ════════════════════════════════════════
  // WESTERN DIGITAL — SATA SSD
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 4TB SATA SSD',
    'specs': {'capacity_gb': 4000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 1000, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 2TB SATA SSD',
    'specs': {'capacity_gb': 2000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 500, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 1TB SATA SSD',
    'specs': {'capacity_gb': 1000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 250, 'nand_type': '3D TLC'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black P40 Game Drive 4TB SATA SSD',
    'specs': {'capacity_gb': 4000, 'type': 'SATA SSD', 'interface': 'SATA III 6Gb/s', 'form_factor': '2.5"', 'read_speed_mbs': 560, 'write_speed_mbs': 530, 'tbw': 1000, 'nand_type': '3D TLC'},
  },

  // ════════════════════════════════════════
  // WESTERN DIGITAL — HDD
  // ════════════════════════════════════════
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black 8TB HDD',
    'specs': {'capacity_gb': 8000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 272, 'write_speed_mbs': 272, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black 6TB HDD',
    'specs': {'capacity_gb': 6000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 255, 'write_speed_mbs': 255, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Black 4TB HDD',
    'specs': {'capacity_gb': 4000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 240, 'write_speed_mbs': 240, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 6TB HDD',
    'specs': {'capacity_gb': 6000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 180, 'write_speed_mbs': 180, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 4TB HDD',
    'specs': {'capacity_gb': 4000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 180, 'write_speed_mbs': 180, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Blue 2TB HDD',
    'specs': {'capacity_gb': 2000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 180, 'write_speed_mbs': 180, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Red Plus 12TB HDD',
    'specs': {'capacity_gb': 12000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 215, 'write_speed_mbs': 215, 'tbw': 0, 'nand_type': 'N/A'},
  },
  {
    'category': 'Storage', 'manufacturer': 'Western Digital', 'model': 'WD Red Plus 8TB HDD',
    'specs': {'capacity_gb': 8000, 'type': 'HDD', 'interface': 'SATA III 6Gb/s', 'form_factor': '3.5"', 'read_speed_mbs': 215, 'write_speed_mbs': 215, 'tbw': 0, 'nand_type': 'N/A'},
  },
];