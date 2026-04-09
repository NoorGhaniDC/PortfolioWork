/// Raw Monitor catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> monitorData = [
  // ── LG ──
  {
    'category': 'Monitor', 'manufacturer': 'LG', 'model': 'UltraGear 27GP950-B 4K 144Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '3840x2160', 'panel_type': 'Nano IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR600', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.1, 1x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'LG', 'model': 'UltraGear 27GR95QE 1440p 240Hz OLED',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'OLED', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 1x DP 1.4, 3x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'LG', 'model': 'UltraGear 32GQ950-B 4K 160Hz',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'Nano IPS', 'refresh_rate_hz': 160, 'response_time_ms': 1, 'hdr': 'HDR1000', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.1, 1x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'LG', 'model': 'UltraWide 34GP950G-B 3440x1440 144Hz',
    'specs': {'screen_size_inch': 34, 'resolution': '3440x1440', 'panel_type': 'Nano IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Ultimate', 'ports': '1x HDMI 2.0, 1x DP 1.4, 3x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'LG', 'model': 'UltraGear 27GP850-B 1440p 165Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'Nano IPS', 'refresh_rate_hz': 165, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 1x DP 1.4, 1x USB-A'},
  },

  // ── Samsung ──
  {
    'category': 'Monitor', 'manufacturer': 'Samsung', 'model': 'Odyssey G7 32" 4K 144Hz',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR600', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.1, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Samsung', 'model': 'Odyssey G8 34" OLED 175Hz',
    'specs': {'screen_size_inch': 34, 'resolution': '3440x1440', 'panel_type': 'QD-OLED', 'refresh_rate_hz': 175, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.1, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Samsung', 'model': 'Odyssey Neo G9 49" 4K 240Hz',
    'specs': {'screen_size_inch': 49, 'resolution': '5120x1440', 'panel_type': 'Mini LED VA', 'refresh_rate_hz': 240, 'response_time_ms': 1, 'hdr': 'HDR2000', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.1, 1x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Samsung', 'model': 'Odyssey G9 49" 1000R 240Hz',
    'specs': {'screen_size_inch': 49, 'resolution': '5120x1440', 'panel_type': 'VA', 'refresh_rate_hz': 240, 'response_time_ms': 1, 'hdr': 'HDR1000', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Samsung', 'model': 'Odyssey G5 27" 1440p 165Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'VA', 'refresh_rate_hz': 165, 'response_time_ms': 1, 'hdr': 'HDR10', 'adaptive_sync': 'FreeSync Premium', 'ports': '1x HDMI 2.0, 1x DP 1.2, 2x USB-A'},
  },

  // ── ASUS ──
  {
    'category': 'Monitor', 'manufacturer': 'ASUS', 'model': 'ROG Swift PG32UQX 4K 144Hz Mini LED',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'IPS Mini LED', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR1400', 'adaptive_sync': 'G-Sync Ultimate', 'ports': '1x HDMI 2.0, 3x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'ASUS', 'model': 'ROG Swift OLED PG27AQDM 1440p 240Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'OLED', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 1x DP 1.4, 3x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'ASUS', 'model': 'TUF Gaming VG27AQZ 1440p 165Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS', 'refresh_rate_hz': 165, 'response_time_ms': 1, 'hdr': 'HDR10', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.0, 2x DP 1.2, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'ASUS', 'model': 'ProArt PA32UCG 4K 120Hz Mini LED',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'IPS Mini LED', 'refresh_rate_hz': 120, 'response_time_ms': 3, 'hdr': 'HDR1600', 'adaptive_sync': 'G-Sync Ultimate', 'ports': '4x HDMI 2.0, 3x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'ASUS', 'model': 'ROG Strix XG27AQM 1440p 270Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS', 'refresh_rate_hz': 270, 'response_time_ms': 0, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.0, 2x DP 1.4, 4x USB-A'},
  },

  // ── MSI ──
  {
    'category': 'Monitor', 'manufacturer': 'MSI', 'model': 'MEG 342C QD-OLED 3440x1440 175Hz',
    'specs': {'screen_size_inch': 34, 'resolution': '3440x1440', 'panel_type': 'QD-OLED', 'refresh_rate_hz': 175, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.1, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'MSI', 'model': 'MAG 274QRF QD 1440p 165Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'Rapid IPS', 'refresh_rate_hz': 165, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.0, 2x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'MSI', 'model': 'Optix MAG274QRX QD-OLED 1440p 240Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'QD-OLED', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'MSI', 'model': 'MAG 281URF QD 4K 144Hz',
    'specs': {'screen_size_inch': 28, 'resolution': '3840x2160', 'panel_type': 'Rapid IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.1, 1x DP 1.4, 2x USB-A'},
  },

  // ── AOC ──
  {
    'category': 'Monitor', 'manufacturer': 'AOC', 'model': 'AGON Pro AG274QZM 1440p 240Hz Mini LED',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS Mini LED', 'refresh_rate_hz': 240, 'response_time_ms': 1, 'hdr': 'HDR1000', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.0, 2x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'AOC', 'model': 'AGON AG275QXN 1440p 170Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS', 'refresh_rate_hz': 170, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'FreeSync Premium Pro', 'ports': '2x HDMI 2.0, 1x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'AOC', 'model': 'U27U2D 4K 144Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '3840x2160', 'panel_type': 'IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'FreeSync Premium', 'ports': '2x HDMI 2.1, 1x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'AOC', 'model': 'CU34G3S 3440x1440 180Hz',
    'specs': {'screen_size_inch': 34, 'resolution': '3440x1440', 'panel_type': 'VA', 'refresh_rate_hz': 180, 'response_time_ms': 1, 'hdr': 'HDR10', 'adaptive_sync': 'FreeSync Premium', 'ports': '2x HDMI 2.0, 1x DP 1.4, 4x USB-A'},
  },

  // ── Gigabyte ──
  {
    'category': 'Monitor', 'manufacturer': 'Gigabyte', 'model': 'AORUS FO32U2P 4K 240Hz OLED',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'WOLED', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR True Black 400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '2x HDMI 2.1, 2x DP 1.4, 4x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Gigabyte', 'model': 'AORUS FI27Q-X 1440p 240Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR400', 'adaptive_sync': 'G-Sync Compatible / FreeSync', 'ports': '1x HDMI 2.0, 2x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Gigabyte', 'model': 'M27Q X 1440p 240Hz',
    'specs': {'screen_size_inch': 27, 'resolution': '2560x1440', 'panel_type': 'IPS', 'refresh_rate_hz': 240, 'response_time_ms': 0, 'hdr': 'HDR400', 'adaptive_sync': 'FreeSync Premium Pro', 'ports': '2x HDMI 2.0, 1x DP 1.4, 2x USB-A'},
  },
  {
    'category': 'Monitor', 'manufacturer': 'Gigabyte', 'model': 'M32U 4K 144Hz',
    'specs': {'screen_size_inch': 32, 'resolution': '3840x2160', 'panel_type': 'IPS', 'refresh_rate_hz': 144, 'response_time_ms': 1, 'hdr': 'HDR400', 'adaptive_sync': 'FreeSync Premium Pro', 'ports': '2x HDMI 2.1, 1x DP 1.4, 2x USB-A'},
  },
];