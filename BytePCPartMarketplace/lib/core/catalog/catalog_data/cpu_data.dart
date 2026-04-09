/// Raw CPU catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> cpuData = [
  // ── AMD Ryzen 7000 Series (AM5 / Zen 4) ──
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 9 7950X',
    'specs': {'cores': 16, 'threads': 32, 'base_clock_ghz': 4.5, 'boost_clock_ghz': 5.7, 'tdp_watts': 170, 'socket': 'AM5', 'architecture': 'Zen 4'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 9 7900X',
    'specs': {'cores': 12, 'threads': 24, 'base_clock_ghz': 4.7, 'boost_clock_ghz': 5.6, 'tdp_watts': 170, 'socket': 'AM5', 'architecture': 'Zen 4'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 7 7700X',
    'specs': {'cores': 8, 'threads': 16, 'base_clock_ghz': 4.5, 'boost_clock_ghz': 5.4, 'tdp_watts': 105, 'socket': 'AM5', 'architecture': 'Zen 4'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 5 7600X',
    'specs': {'cores': 6, 'threads': 12, 'base_clock_ghz': 4.7, 'boost_clock_ghz': 5.3, 'tdp_watts': 105, 'socket': 'AM5', 'architecture': 'Zen 4'},
  },
  // ── AMD Ryzen 5000 Series (AM4 / Zen 3) ──
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 9 5950X',
    'specs': {'cores': 16, 'threads': 32, 'base_clock_ghz': 3.4, 'boost_clock_ghz': 4.9, 'tdp_watts': 105, 'socket': 'AM4', 'architecture': 'Zen 3'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 9 5900X',
    'specs': {'cores': 12, 'threads': 24, 'base_clock_ghz': 3.7, 'boost_clock_ghz': 4.8, 'tdp_watts': 105, 'socket': 'AM4', 'architecture': 'Zen 3'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 7 5800X',
    'specs': {'cores': 8, 'threads': 16, 'base_clock_ghz': 3.8, 'boost_clock_ghz': 4.7, 'tdp_watts': 105, 'socket': 'AM4', 'architecture': 'Zen 3'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 7 5800X3D',
    'specs': {'cores': 8, 'threads': 16, 'base_clock_ghz': 3.4, 'boost_clock_ghz': 4.5, 'tdp_watts': 105, 'socket': 'AM4', 'architecture': 'Zen 3 (3D V-Cache)'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 5 5600X',
    'specs': {'cores': 6, 'threads': 12, 'base_clock_ghz': 3.7, 'boost_clock_ghz': 4.6, 'tdp_watts': 65, 'socket': 'AM4', 'architecture': 'Zen 3'},
  },
  {
    'category': 'CPU', 'manufacturer': 'AMD', 'model': 'Ryzen 5 5600',
    'specs': {'cores': 6, 'threads': 12, 'base_clock_ghz': 3.5, 'boost_clock_ghz': 4.4, 'tdp_watts': 65, 'socket': 'AM4', 'architecture': 'Zen 3'},
  },
  // ── Intel 13th Gen (LGA1700 / Raptor Lake) ──
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i9-13900K',
    'specs': {'cores': 24, 'threads': 32, 'base_clock_ghz': 3.0, 'boost_clock_ghz': 5.8, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Raptor Lake'},
  },
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i7-13700K',
    'specs': {'cores': 16, 'threads': 24, 'base_clock_ghz': 3.4, 'boost_clock_ghz': 5.4, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Raptor Lake'},
  },
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i5-13600K',
    'specs': {'cores': 14, 'threads': 20, 'base_clock_ghz': 3.5, 'boost_clock_ghz': 5.1, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Raptor Lake'},
  },
  // ── Intel 12th Gen (LGA1700 / Alder Lake) ──
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i9-12900K',
    'specs': {'cores': 16, 'threads': 24, 'base_clock_ghz': 3.2, 'boost_clock_ghz': 5.2, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Alder Lake'},
  },
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i7-12700K',
    'specs': {'cores': 12, 'threads': 20, 'base_clock_ghz': 3.6, 'boost_clock_ghz': 5.0, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Alder Lake'},
  },
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i5-12600K',
    'specs': {'cores': 10, 'threads': 16, 'base_clock_ghz': 3.7, 'boost_clock_ghz': 4.9, 'tdp_watts': 125, 'socket': 'LGA1700', 'architecture': 'Alder Lake'},
  },
  {
    'category': 'CPU', 'manufacturer': 'Intel', 'model': 'Core i5-12400',
    'specs': {'cores': 6, 'threads': 12, 'base_clock_ghz': 2.5, 'boost_clock_ghz': 4.4, 'tdp_watts': 65, 'socket': 'LGA1700', 'architecture': 'Alder Lake'},
  },
];