/// Raw Motherboard catalog data.
/// Each entry: category, manufacturer, model, specs (keys must match SpecsSchema).
const List<Map<String, dynamic>> motherboardData = [
  // ── ASUS AM5 (Zen 4) ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Crosshair X670E Extreme',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 5, 'usb_ports': '10x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Strix X670E-F Gaming WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'TUF Gaming X670E-Plus WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ProArt X670E-Creator WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '10x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Strix B650E-F Gaming WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 4, 'usb_ports': '6x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'TUF Gaming B650-Plus WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  // ── ASUS LGA1700 (Intel 12th/13th Gen) ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Maximus Z790 Extreme',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 4, 'm2_slots': 5, 'usb_ports': '12x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Strix Z790-E Gaming WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 5, 'usb_ports': '10x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'TUF Gaming Z790-Plus WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'Prime Z790-P WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },

  // ── MSI AM5 ──
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MEG X670E Godlike',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 4, 'm2_slots': 6, 'usb_ports': '12x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MPG X670E Carbon WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 5, 'usb_ports': '8x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MAG X670E Tomahawk WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MAG B650 Tomahawk WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'Pro B650-S WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  // ── MSI LGA1700 ──
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MEG Z790 Godlike',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 4, 'm2_slots': 6, 'usb_ports': '12x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MPG Z790 Carbon WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 5, 'usb_ports': '8x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MAG Z790 Tomahawk WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'Pro Z790-A WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },

  // ── Gigabyte AM5 ──
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'X670E Aorus Master',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '8x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'X670E Aorus Xtreme',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 4, 'm2_slots': 5, 'usb_ports': '10x USB-A, 4x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B650 Aorus Elite AX',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B650M Aorus Elite AX',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 2x USB-C'},
  },
  // ── Gigabyte LGA1700 ──
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'Z790 Aorus Master',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 5, 'usb_ports': '8x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'Z790 Aorus Xtreme X',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 4, 'm2_slots': 6, 'usb_ports': '12x USB-A, 5x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B760 Aorus Elite AX',
    'specs': {'socket': 'LGA1700', 'chipset': 'B760', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },

  // ── ASRock AM5 ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'X670E Taichi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '10x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'X670E Steel Legend WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'X670E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B650E Steel Legend WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650E', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B650M Pro RS WiFi',
    'specs': {'socket': 'AM5', 'chipset': 'B650', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 1x USB-C'},
  },
  // ── ASRock LGA1700 ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'Z790 Taichi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '10x USB-A, 3x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'Z790 Steel Legend WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'Z790', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B760M Steel Legend WiFi',
    'specs': {'socket': 'LGA1700', 'chipset': 'B760', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR5', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 2x USB-C'},
  },

  // ── ASUS AM4 (Zen 3 / Zen 2) ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Crosshair VIII Dark Hero',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 4, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Strix X570-E Gaming WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '8x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'TUF Gaming X570-Plus WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'ROG Strix B550-F Gaming WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'TUF Gaming B550-Plus WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASUS', 'model': 'Prime B550M-A WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 1x USB-C'},
  },

  // ── MSI AM4 ──
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MEG X570 Godlike',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 4, 'm2_slots': 3, 'usb_ports': '10x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MPG X570S Carbon Max WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '8x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MAG X570S Tomahawk Max WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MAG B550 Tomahawk',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'MPG B550 Gaming Edge WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'MSI', 'model': 'Pro B550M-VC WiFi',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 1, 'usb_ports': '4x USB-A, 1x USB-C'},
  },

  // ── Gigabyte AM4 ──
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'X570 Aorus Master',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '8x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'X570 Aorus Xtreme',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'E-ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '10x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B550 Aorus Pro AX',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B550 Gaming X V2',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'Gigabyte', 'model': 'B550M Aorus Elite',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 1x USB-C'},
  },

  // ── ASRock AM4 ──
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'X570 Taichi',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 3, 'm2_slots': 3, 'usb_ports': '8x USB-A, 2x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'X570 Steel Legend WiFi ax',
    'specs': {'socket': 'AM4', 'chipset': 'X570', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B550 Steel Legend',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'ATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 3, 'usb_ports': '6x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B550M Steel Legend',
    'specs': {'socket': 'AM4', 'chipset': 'B550', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 128, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 2, 'usb_ports': '4x USB-A, 1x USB-C'},
  },
  {
    'category': 'Motherboard', 'manufacturer': 'ASRock', 'model': 'B450M Steel Legend',
    'specs': {'socket': 'AM4', 'chipset': 'B450', 'form_factor': 'mATX', 'memory_slots': 4, 'max_memory_gb': 64, 'memory_type': 'DDR4', 'pcie_slots': 2, 'm2_slots': 1, 'usb_ports': '4x USB-A, 1x USB-C'},
  },
];