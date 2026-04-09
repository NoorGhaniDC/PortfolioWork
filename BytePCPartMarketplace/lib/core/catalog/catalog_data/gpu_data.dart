/// Raw GPU catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> gpuData = [
  // ── NVIDIA RTX 4000 Series (Ada Lovelace) ──
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4090 Founders Edition',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2520, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4080 Founders Edition',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2505, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4070 Ti Founders Edition',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2310, 'boost_clock_mhz': 2610, 'tdp_watts': 285, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4070 Ti SUPER Founders Edition',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2340, 'boost_clock_mhz': 2610, 'tdp_watts': 285, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4070 SUPER Founders Edition',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1980, 'boost_clock_mhz': 2475, 'tdp_watts': 220, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4070 Founders Edition',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2475, 'tdp_watts': 200, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4060 Ti Founders Edition',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 2310, 'boost_clock_mhz': 2535, 'tdp_watts': 160, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 4060 Founders Edition',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1830, 'boost_clock_mhz': 2460, 'tdp_watts': 115, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '8-pin'},
  },
  // ── NVIDIA RTX 3000 Series (Ampere) ──
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3090 Ti Founders Edition',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1560, 'boost_clock_mhz': 1860, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ampere', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3090 Founders Edition',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1395, 'boost_clock_mhz': 1695, 'tdp_watts': 350, 'slot_width': '3-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3080 Ti Founders Edition',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1365, 'boost_clock_mhz': 1665, 'tdp_watts': 350, 'slot_width': '3-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3080 Founders Edition',
    'specs': {'vram_gb': 10, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1440, 'boost_clock_mhz': 1710, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3070 Ti Founders Edition',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1575, 'boost_clock_mhz': 1770, 'tdp_watts': 290, 'slot_width': '2-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3070 Founders Edition',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1500, 'boost_clock_mhz': 1725, 'tdp_watts': 220, 'slot_width': '2-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3060 Ti Founders Edition',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1410, 'boost_clock_mhz': 1665, 'tdp_watts': 200, 'slot_width': '2-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'NVIDIA', 'model': 'RTX 3060 Founders Edition',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6', 'base_clock_mhz': 1320, 'boost_clock_mhz': 1777, 'tdp_watts': 170, 'slot_width': '2-slot', 'architecture': 'Ampere', 'connector': '12-pin'},
  },
  // ── AMD RX 7000 Series (RDNA 3) ──
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 7900 XTX Reference Card',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6', 'base_clock_mhz': 1855, 'boost_clock_mhz': 2500, 'tdp_watts': 355, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 7900 XT Reference Card',
    'specs': {'vram_gb': 20, 'vram_type': 'GDDR6', 'base_clock_mhz': 1500, 'boost_clock_mhz': 2400, 'tdp_watts': 315, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 7800 XT Reference Card',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1295, 'boost_clock_mhz': 2430, 'tdp_watts': 263, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 7700 XT Reference Card',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6', 'base_clock_mhz': 1700, 'boost_clock_mhz': 2544, 'tdp_watts': 245, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  // ── AMD RX 6000 Series (RDNA 2) ──
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 6950 XT Reference Card',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1860, 'boost_clock_mhz': 2310, 'tdp_watts': 335, 'slot_width': '2-slot', 'architecture': 'RDNA 2', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 6800 XT Reference Card',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1825, 'boost_clock_mhz': 2250, 'tdp_watts': 300, 'slot_width': '2-slot', 'architecture': 'RDNA 2', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'AMD', 'model': 'Radeon RX 6700 XT Reference Card',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6', 'base_clock_mhz': 2321, 'boost_clock_mhz': 2581, 'tdp_watts': 230, 'slot_width': '2-slot', 'architecture': 'RDNA 2', 'connector': '2x 8-pin'},
  },

  // ── ASUS ROG Astral (RTX 50 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Astral LC GeForce RTX 5090 32GB OC',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2407, 'tdp_watts': 575, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Astral GeForce RTX 5090 32GB OC',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2407, 'tdp_watts': 575, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Astral GeForce RTX 5080 16GB OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2617, 'tdp_watts': 360, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── ASUS ROG Matrix ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Matrix GeForce RTX 5090',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2445, 'tdp_watts': 600, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Matrix GeForce RTX 4090',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2595, 'tdp_watts': 516, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── ASUS ROG Strix ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Strix GeForce RTX 4070 Ti SUPER 16GB OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2340, 'boost_clock_mhz': 2670, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Strix GeForce RTX 4070 SUPER 12GB OC',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1980, 'boost_clock_mhz': 2535, 'tdp_watts': 220, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Strix GeForce RTX 5070 Ti',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2452, 'tdp_watts': 300, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ROG Strix GeForce RTX 5070',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR7', 'base_clock_mhz': 2062, 'boost_clock_mhz': 2512, 'tdp_watts': 250, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── ASUS TUF Gaming ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming GeForce RTX 5090',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2407, 'tdp_watts': 575, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming GeForce RTX 5080',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2617, 'tdp_watts': 360, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming GeForce RTX 5070 Ti',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2452, 'tdp_watts': 300, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming GeForce RTX 5070',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR7', 'base_clock_mhz': 2062, 'boost_clock_mhz': 2512, 'tdp_watts': 250, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming GeForce RTX 4070 Ti SUPER BTF White OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2340, 'boost_clock_mhz': 2640, 'tdp_watts': 285, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'TUF Gaming AMD Radeon RX 9070 XT',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2970, 'tdp_watts': 304, 'slot_width': '2-slot', 'architecture': 'RDNA 4', 'connector': '2x 8-pin'},
  },
  // ── ASUS ProArt ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ProArt GeForce RTX 4080 SUPER',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2550, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'ProArt GeForce RTX 4070 Ti',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2310, 'boost_clock_mhz': 2610, 'tdp_watts': 285, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── ASUS Prime ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Prime GeForce RTX 5080',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2617, 'tdp_watts': 360, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Prime GeForce RTX 5070 Ti 16GB OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2452, 'tdp_watts': 300, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Prime GeForce RTX 5070 OC 12GB',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR7', 'base_clock_mhz': 2062, 'boost_clock_mhz': 2512, 'tdp_watts': 250, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Prime Radeon RX 9070 XT OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2970, 'tdp_watts': 304, 'slot_width': '2-slot', 'architecture': 'RDNA 4', 'connector': '2x 8-pin'},
  },
  // ── ASUS Dual ──
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Dual GeForce RTX 5060 8GB OC',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR7', 'base_clock_mhz': 1875, 'boost_clock_mhz': 2497, 'tdp_watts': 150, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Dual GeForce RTX 5060 Ti EVO OC 16GB',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2130, 'boost_clock_mhz': 2572, 'tdp_watts': 180, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Dual GeForce RTX 4070 SUPER EVO OC 12GB',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1980, 'boost_clock_mhz': 2535, 'tdp_watts': 220, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'ASUS', 'model': 'Dual GeForce RTX 5070 12GB OC',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR7', 'base_clock_mhz': 2062, 'boost_clock_mhz': 2512, 'tdp_watts': 250, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },

  // ── XFX RX 9000 Series (RDNA 4) ──
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster SWFT RX 9070 XT',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2970, 'tdp_watts': 304, 'slot_width': '2-slot', 'architecture': 'RDNA 4', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster SWFT RX 9060 XT',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1800, 'boost_clock_mhz': 2589, 'tdp_watts': 182, 'slot_width': '2-slot', 'architecture': 'RDNA 4', 'connector': '8-pin'},
  },
  // ── XFX RX 7000 Series (RDNA 3) ──
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster MERC 310 Radeon RX 7900 XTX',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6', 'base_clock_mhz': 1855, 'boost_clock_mhz': 2615, 'tdp_watts': 355, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster MERC 310 Radeon RX 7900 XT',
    'specs': {'vram_gb': 20, 'vram_type': 'GDDR6', 'base_clock_mhz': 1500, 'boost_clock_mhz': 2535, 'tdp_watts': 315, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster QICK 319 Radeon RX 7900 GRE',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1564, 'boost_clock_mhz': 2245, 'tdp_watts': 260, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster QICK 319 Radeon RX 7800 XT',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1295, 'boost_clock_mhz': 2430, 'tdp_watts': 263, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster SWFT 210 Radeon RX 7700 XT',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6', 'base_clock_mhz': 1700, 'boost_clock_mhz': 2544, 'tdp_watts': 245, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'XFX', 'model': 'Speedster SWFT 210 Radeon RX 7600',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1720, 'boost_clock_mhz': 2655, 'tdp_watts': 165, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '8-pin'},
  },

  // ── Gigabyte AORUS (RTX 50 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5090 Master 32G',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2430, 'tdp_watts': 575, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5090 Xtreme Waterforce 32G',
    'specs': {'vram_gb': 32, 'vram_type': 'GDDR7', 'base_clock_mhz': 2010, 'boost_clock_mhz': 2445, 'tdp_watts': 575, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5080 Master 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2640, 'tdp_watts': 360, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5080 Xtreme Waterforce 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2655, 'tdp_watts': 360, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5070 Ti Master 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR7', 'base_clock_mhz': 2295, 'boost_clock_mhz': 2475, 'tdp_watts': 300, 'slot_width': '3-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 5070 Master 12G',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR7', 'base_clock_mhz': 2062, 'boost_clock_mhz': 2535, 'tdp_watts': 250, 'slot_width': '2-slot', 'architecture': 'Blackwell', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── Gigabyte AORUS (RTX 40 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 4090 Master 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2550, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 4090 Xtreme Waterforce 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2565, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 4080 Super Master 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2610, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 4080 16GB Master',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2580, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS GeForce RTX 4070 Ti Super Master 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2340, 'boost_clock_mhz': 2670, 'tdp_watts': 285, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── Gigabyte Gaming OC (RTX 40 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4090 Gaming OC 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2535, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4080 Super Gaming OC 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2595, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4080 16GB Gaming OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2565, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4070 Ti Super Gaming OC 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2340, 'boost_clock_mhz': 2655, 'tdp_watts': 285, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4070 Super Gaming OC 12G',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1980, 'boost_clock_mhz': 2535, 'tdp_watts': 220, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4070 Gaming OC 12G',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2505, 'tdp_watts': 200, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4060 Ti Gaming OC 8G',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 2310, 'boost_clock_mhz': 2565, 'tdp_watts': 160, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4060 Gaming OC 8G',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1830, 'boost_clock_mhz': 2490, 'tdp_watts': 115, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '8-pin'},
  },
  // ── Gigabyte Aero OC / Eagle OC (RTX 40 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4090 Aero OC 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2535, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4080 16GB Eagle OC',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2205, 'boost_clock_mhz': 2550, 'tdp_watts': 320, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  // ── Gigabyte WINDFORCE (RTX 40 Series) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4090 Windforce V2 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6X', 'base_clock_mhz': 2235, 'boost_clock_mhz': 2520, 'tdp_watts': 450, 'slot_width': '3-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4070 Windforce OC 12G',
    'specs': {'vram_gb': 12, 'vram_type': 'GDDR6X', 'base_clock_mhz': 1920, 'boost_clock_mhz': 2490, 'tdp_watts': 200, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '16-pin (PCIe 5.0)'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'GeForce RTX 4060 Windforce OC 8G',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1830, 'boost_clock_mhz': 2475, 'tdp_watts': 115, 'slot_width': '2-slot', 'architecture': 'Ada Lovelace', 'connector': '8-pin'},
  },
  // ── Gigabyte RX 7000 Series (RDNA 3) ──
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'AORUS Radeon RX 7900 XTX Elite 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6', 'base_clock_mhz': 1855, 'boost_clock_mhz': 2680, 'tdp_watts': 355, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'Radeon RX 7900 XTX Gaming OC 24G',
    'specs': {'vram_gb': 24, 'vram_type': 'GDDR6', 'base_clock_mhz': 1855, 'boost_clock_mhz': 2525, 'tdp_watts': 355, 'slot_width': '3-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'Radeon RX 7900 GRE Gaming OC 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1564, 'boost_clock_mhz': 2391, 'tdp_watts': 260, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'Radeon RX 7800 XT Gaming OC 16G',
    'specs': {'vram_gb': 16, 'vram_type': 'GDDR6', 'base_clock_mhz': 1295, 'boost_clock_mhz': 2430, 'tdp_watts': 263, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '2x 8-pin'},
  },
  {
    'category': 'GPU', 'manufacturer': 'Gigabyte', 'model': 'Radeon RX 7600 Gaming OC 8G',
    'specs': {'vram_gb': 8, 'vram_type': 'GDDR6', 'base_clock_mhz': 1720, 'boost_clock_mhz': 2655, 'tdp_watts': 165, 'slot_width': '2-slot', 'architecture': 'RDNA 3', 'connector': '8-pin'},
  },
];