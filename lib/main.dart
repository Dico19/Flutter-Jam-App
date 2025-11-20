import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const JamApp());
}

class JamApp extends StatelessWidget {
  const JamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Jam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pages = const [
    BerandaPage(),
    AlarmPage(),
    WorldClockPage(),
    StopwatchPage(),
    TimerPage(),
  ];

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Beranda';
      case 1:
        return 'Alarm';
      case 2:
        return 'Jam Dunia';
      case 3:
        return 'Stopwatch';
      case 4:
        return 'Timer';
      default:
        return 'Aplikasi Jam';
    }
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF141414), Color(0xFF1E1E2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            _getTitle(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onNavTapped,
          backgroundColor: const Color(0xFF11111A),
          indicatorColor: Colors.deepPurple.withOpacity(0.3),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.alarm_outlined),
              selectedIcon: Icon(Icons.alarm),
              label: 'Alarm',
            ),
            NavigationDestination(
              icon: Icon(Icons.public_outlined),
              selectedIcon: Icon(Icons.public),
              label: 'Jam Dunia',
            ),
            NavigationDestination(
              icon: Icon(Icons.timer_outlined),
              selectedIcon: Icon(Icons.timer),
              label: 'Stopwatch',
            ),
            NavigationDestination(
              icon: Icon(Icons.hourglass_bottom_outlined),
              selectedIcon: Icon(Icons.hourglass_bottom),
              label: 'Timer',
            ),
          ],
        ),
      ),
    );
  }
}

/// =================== LAYER 1: BERANDA ===================
class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(time.hour)}:${two(time.minute)}:${two(time.second)}';
  }

  String _formatDate(DateTime time) {
    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final h = hari[(time.weekday - 1) % 7];
    final b = bulan[(time.month - 1) % 12];

    return '$h, ${time.day} $b ${time.year}';
  }

  String _greeting(DateTime time) {
    final h = time.hour;
    if (h >= 4 && h < 11) {
      return 'Selamat pagi';
    } else if (h >= 11 && h < 15) {
      return 'Selamat siang';
    } else if (h >= 15 && h < 18) {
      return 'Selamat sore';
    } else {
      return 'Selamat malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    final jam = _formatTime(_now);
    final tanggal = _formatDate(_now);
    final greet = _greeting(_now);

    return Stack(
      children: [
        // Background dekorasi lembut
        Positioned(
          top: -80,
          left: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.5),
                  Colors.blue.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          right: -40,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.pink.withOpacity(0.2),
                  Colors.deepPurple.withOpacity(0.4),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),

        // Konten utama
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                '$greet 👋',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tanggal,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              const Text(
                'Selamat datang di aplikasi jam Dicoding.\n'
                'Kelola waktu, alarm, dan aktivitas harian dengan mudah.',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 32),

              // Kartu jam utama
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 28,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3F51B5), Color(0xFF9C27B0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Waktu sekarang',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        jam,
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Zona waktu lokal (perkiraan)',
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Cepat akses',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  _QuickFeatureCard(icon: Icons.alarm_rounded, label: 'Alarm'),
                  SizedBox(width: 12),
                  _QuickFeatureCard(
                    icon: Icons.language_rounded,
                    label: 'Jam dunia',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  _QuickFeatureCard(
                    icon: Icons.timer_rounded,
                    label: 'Stopwatch',
                  ),
                  SizedBox(width: 12),
                  _QuickFeatureCard(
                    icon: Icons.hourglass_top_rounded,
                    label: 'Timer',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Kartu kecil untuk "Cepat akses"
class _QuickFeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickFeatureCard({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
              child: Icon(icon, size: 22, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== lanjut dengan AlarmData seperti semula ======
class AlarmData {
  TimeOfDay time;
  Set<int> days; // 1=Senin ... 7=Minggu
  bool enabled;
  String name;
  String sound;
  bool vibrate;
  bool snoozeEnabled;
  int snoozeMinutes;
  int snoozeTimes;

  AlarmData({
    required this.time,
    required this.days,
    this.enabled = true,
    this.name = '',
    this.sound = 'Nada default',
    this.vibrate = true,
    this.snoozeEnabled = true,
    this.snoozeMinutes = 5,
    this.snoozeTimes = 3,
  });

  bool get everyday => days.length == 7;
}

/// =================== LAYER 2: ALARM (LIST) ===================
class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final List<AlarmData> _alarms = [];

  String _dayShort(int weekday) {
    const labels = ['M', 'S', 'R', 'K', 'J', 'S', 'M'];
    return labels[weekday - 1];
  }

  String _dayFull(int weekday) {
    const names = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return names[weekday - 1];
  }

  String _formatTime(TimeOfDay time) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(time.hour)}:${two(time.minute)}';
  }

  String _subtitleForAlarm(AlarmData a) {
    if (a.everyday) return 'Setiap hari';
    if (a.days.isEmpty) return 'Tidak berulang';
    final list = a.days.toList()..sort();
    return list.map((d) => _dayShort(d)).join(', ');
  }

  /// hitung alarm berikutnya yang aktif
  DateTime? _nextAlarmDateTime() {
    if (_alarms.isEmpty) return null;

    final now = DateTime.now();
    DateTime? closest;

    for (final alarm in _alarms) {
      if (!alarm.enabled) continue;

      for (int offset = 0; offset < 7; offset++) {
        final day = now.add(Duration(days: offset));
        final weekday = day.weekday; // 1..7

        if (!alarm.everyday && !alarm.days.contains(weekday)) continue;

        final candidate = DateTime(
          day.year,
          day.month,
          day.day,
          alarm.time.hour,
          alarm.time.minute,
        );

        if (!candidate.isAfter(now)) continue;

        if (closest == null || candidate.isBefore(closest!)) {
          closest = candidate;
        }
        break;
      }
    }

    return closest;
  }

  String _summaryTitle() {
    final next = _nextAlarmDateTime();
    if (next == null) return 'Tidak ada alarm aktif';

    final now = DateTime.now();
    final diff = next.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;

    if (hours <= 0 && minutes <= 0) {
      return 'Alarm sebentar lagi';
    }
    return 'Alarm $hours jam $minutes menit lagi';
  }

  String _summarySubtitle() {
    final next = _nextAlarmDateTime();
    if (next == null) return 'Tekan + untuk menambahkan alarm';

    const dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    final dayName = dayNames[next.weekday - 1];
    final monthName = monthNames[next.month - 1];

    String two(int n) => n.toString().padLeft(2, '0');
    final timeText = '${two(next.hour)}.${two(next.minute)}';

    return '$dayName, ${next.day} $monthName $timeText';
  }

  Future<void> _addAlarm() async {
    final result = await Navigator.push<AlarmData>(
      context,
      MaterialPageRoute(builder: (_) => const AlarmEditPage()),
    );
    if (result != null) {
      setState(() {
        _alarms.add(result);
      });
    }
  }

  Future<void> _editAlarm(int index) async {
    final current = _alarms[index];
    final result = await Navigator.push<AlarmData>(
      context,
      MaterialPageRoute(builder: (_) => AlarmEditPage(initial: current)),
    );
    if (result != null) {
      setState(() {
        _alarms[index] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _summaryTitle(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _summarySubtitle(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _addAlarm,
                icon: const Icon(Icons.add, size: 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _alarms.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada alarm.\nTekan tombol + untuk menambahkan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = _alarms[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => _editAlarm(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _formatTime(alarm.time),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: alarm.enabled
                                        ? Colors.white
                                        : Colors.white38,
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      _subtitleForAlarm(alarm),
                                      style: TextStyle(
                                        color: alarm.enabled
                                            ? Colors.white
                                            : Colors.white38,
                                      ),
                                    ),
                                    if (alarm.name.isNotEmpty)
                                      Text(
                                        alarm.name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: alarm.enabled
                                              ? Colors.white70
                                              : Colors.white24,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Switch(
                                  value: alarm.enabled,
                                  onChanged: (val) {
                                    setState(() {
                                      alarm.enabled = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// ============ HALAMAN EDIT / TAMBAH ALARM ===============
class AlarmEditPage extends StatefulWidget {
  final AlarmData? initial;

  const AlarmEditPage({super.key, this.initial});

  @override
  State<AlarmEditPage> createState() => _AlarmEditPageState();
}

class _AlarmEditPageState extends State<AlarmEditPage> {
  late TimeOfDay _selectedTime;
  late Set<int> _selectedDays;
  late bool _everyday;
  late TextEditingController _nameController;
  late String _alarmSound;
  late bool _vibrate;
  late bool _snoozeEnabled;
  late int _snoozeMinutes;
  late int _snoozeTimes;

  String _formatTime(TimeOfDay time) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(time.hour)}:${two(time.minute)}';
  }

  @override
  void initState() {
    super.initState();
    final a = widget.initial;
    if (a != null) {
      _selectedTime = a.time;
      _selectedDays = {...a.days};
      _everyday = a.everyday;
      _nameController = TextEditingController(text: a.name);
      _alarmSound = a.sound;
      _vibrate = a.vibrate;
      _snoozeEnabled = a.snoozeEnabled;
      _snoozeMinutes = a.snoozeMinutes;
      _snoozeTimes = a.snoozeTimes;
    } else {
      _selectedTime = const TimeOfDay(hour: 7, minute: 0);
      _selectedDays = {1, 2, 3, 4, 5, 6, 7};
      _everyday = true;
      _nameController = TextEditingController();
      _alarmSound = 'Nada default';
      _vibrate = true;
      _snoozeEnabled = true;
      _snoozeMinutes = 5;
      _snoozeTimes = 3;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _dayLabel(int i) {
    const labels = ['M', 'S', 'R', 'K', 'J', 'S', 'M'];
    return labels[i - 1];
  }

  String _dayFullName(int i) {
    const names = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return names[i - 1];
  }

  void _toggleDay(int dayIndex) {
    setState(() {
      if (_selectedDays.contains(dayIndex)) {
        _selectedDays.remove(dayIndex);
      } else {
        _selectedDays.add(dayIndex);
      }
      if (_selectedDays.length == 7) {
        _everyday = true;
      } else {
        _everyday = false;
      }
    });
  }

  void _toggleEveryday(bool value) {
    setState(() {
      _everyday = value;
      if (_everyday) {
        _selectedDays
          ..clear()
          ..addAll({1, 2, 3, 4, 5, 6, 7});
      }
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _chooseSound() async {
    final sounds = ['Nada default', 'Lagu 1', 'Lagu 2'];
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Pilih suara alarm'),
        children: sounds
            .map(
              (s) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, s),
                child: Text(s),
              ),
            )
            .toList(),
      ),
    );

    if (picked != null) {
      setState(() {
        _alarmSound = picked;
      });
    }
  }

  void _save() {
    final alarm = AlarmData(
      time: _selectedTime,
      days: {..._selectedDays},
      enabled: true,
      name: _nameController.text.trim(),
      sound: _alarmSound,
      vibrate: _vibrate,
      snoozeEnabled: _snoozeEnabled,
      snoozeMinutes: _snoozeMinutes,
      snoozeTimes: _snoozeTimes,
    );
    Navigator.pop(context, alarm);
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _formatTime(_selectedTime);

    return Scaffold(
      appBar: AppBar(title: const Text('Atur Alarm')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// JAM BESAR
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: _pickTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, size: 32),
                      const SizedBox(width: 16),
                      Text(
                        timeText,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// SETIAP HARI + HARI-HARI
            SwitchListTile(
              title: const Text('Setiap hari'),
              value: _everyday,
              onChanged: _toggleEveryday,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(7, (index) {
                final dayIndex = index + 1;
                final selected = _selectedDays.contains(dayIndex);
                return ChoiceChip(
                  label: Text(_dayLabel(dayIndex)),
                  selected: selected,
                  onSelected: (val) {
                    if (_everyday) return;
                    _toggleDay(dayIndex);
                  },
                  tooltip: _dayFullName(dayIndex),
                );
              }),
            ),
            const SizedBox(height: 24),

            /// NAMA ALARM
            const Text(
              'Nama alarm',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Contoh: Bangun pagi',
              ),
            ),
            const SizedBox(height: 24),

            /// SUARA
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Suara alarm'),
              subtitle: Text(_alarmSound),
              trailing: const Icon(Icons.chevron_right),
              onTap: _chooseSound,
            ),
            const Divider(),

            /// GETAR
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Getar'),
              subtitle: const Text('Basic call'),
              value: _vibrate,
              onChanged: (val) {
                setState(() => _vibrate = val);
              },
            ),
            const Divider(),

            /// TIDUR SEBENTAR
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tidur sebentar'),
              subtitle: Text('${_snoozeMinutes} menit, $_snoozeTimes kali'),
              value: _snoozeEnabled,
              onChanged: (val) {
                setState(() => _snoozeEnabled = val);
              },
            ),
            if (_snoozeEnabled) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Durasi:'),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: _snoozeMinutes,
                    items: const [
                      DropdownMenuItem(value: 5, child: Text('5 menit')),
                      DropdownMenuItem(value: 10, child: Text('10 menit')),
                      DropdownMenuItem(value: 15, child: Text('15 menit')),
                    ],
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() => _snoozeMinutes = val);
                    },
                  ),
                  const SizedBox(width: 24),
                  const Text('Ulang:'),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: _snoozeTimes,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('1 kali')),
                      DropdownMenuItem(value: 3, child: Text('3 kali')),
                      DropdownMenuItem(value: 5, child: Text('5 kali')),
                    ],
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() => _snoozeTimes = val);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batalkan'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: _save,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =================== LAYER 3: JAM DUNIA ===================
class WorldClockPage extends StatefulWidget {
  const WorldClockPage({Key? key}) : super(key: key);

  @override
  State<WorldClockPage> createState() => _WorldClockPageState();
}

class _WorldClockPageState extends State<WorldClockPage> {
  late Timer _timer;
  DateTime _nowUtc = DateTime.now().toUtc();

  // Kota yang ditampilkan di halaman utama
  final List<WorldCity> _selectedCities = [
    allWorldCities.firstWhere((c) => c.id == 'jakarta'),
    allWorldCities.firstWhere((c) => c.id == 'london'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _nowUtc = DateTime.now().toUtc();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  DateTime _cityTime(WorldCity city) {
    return _nowUtc.add(city.utcOffset);
  }

  String _formatTime(DateTime time) {
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    return '$hh.$mm';
  }

  String _formatLocalClock(DateTime time) {
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    final ss = time.second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  String _subtitleFor(WorldCity city) {
    final localOffset = DateTime.now().timeZoneOffset;
    final diff = city.utcOffset - localOffset;

    if (diff.inHours == 0) {
      return 'Zona waktu lokal';
    } else if (diff.isNegative) {
      final h = diff.inHours.abs();
      return 'Sekitar $h jam lebih lambat';
    } else {
      final h = diff.inHours;
      return 'Sekitar $h jam lebih cepat';
    }
  }

  Future<void> _openAddCity() async {
    final result = await Navigator.of(context).push<WorldCity>(
      MaterialPageRoute(
        builder: (_) => AddCityPage(
          alreadySelectedIds: _selectedCities.map((c) => c.id).toSet(),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedCities.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localTime = _nowUtc.add(DateTime.now().timeZoneOffset);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Jam Dunia',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _openAddCity),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              _formatLocalClock(localTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Waktu saat ini (perkiraan)',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: _selectedCities.length,
                itemBuilder: (context, index) {
                  final city = _selectedCities[index];
                  final time = _cityTime(city);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF181818),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  city.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _subtitleFor(city),
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _formatTime(time),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =================== MODEL & DATA KOTA ===================

class WorldCity {
  final String id;
  final String name;
  final String country;
  final String continent; // Asia, Eropa, Amerika, Afrika, Oseania
  final Duration utcOffset; // offset dari UTC

  const WorldCity({
    required this.id,
    required this.name,
    required this.country,
    required this.continent,
    required this.utcOffset,
  });
}

// 100 kota besar dunia
const List<WorldCity> allWorldCities = [
  // ===== ASIA (31) =====
  WorldCity(
    id: 'jakarta',
    name: 'Jakarta',
    country: 'Indonesia',
    continent: 'Asia',
    utcOffset: Duration(hours: 7),
  ),
  WorldCity(
    id: 'tokyo',
    name: 'Tokyo',
    country: 'Jepang',
    continent: 'Asia',
    utcOffset: Duration(hours: 9),
  ),
  WorldCity(
    id: 'singapore',
    name: 'Singapura',
    country: 'Singapura',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'bangkok',
    name: 'Bangkok',
    country: 'Thailand',
    continent: 'Asia',
    utcOffset: Duration(hours: 7),
  ),
  WorldCity(
    id: 'kualalumpur',
    name: 'Kuala Lumpur',
    country: 'Malaysia',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'hongkong',
    name: 'Hong Kong',
    country: 'Tiongkok',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'beijing',
    name: 'Beijing',
    country: 'Tiongkok',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'shanghai',
    name: 'Shanghai',
    country: 'Tiongkok',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'shenzhen',
    name: 'Shenzhen',
    country: 'Tiongkok',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'guangzhou',
    name: 'Guangzhou',
    country: 'Tiongkok',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'seoul',
    name: 'Seoul',
    country: 'Korea Selatan',
    continent: 'Asia',
    utcOffset: Duration(hours: 9),
  ),
  WorldCity(
    id: 'manila',
    name: 'Manila',
    country: 'Filipina',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'newdelhi',
    name: 'New Delhi',
    country: 'India',
    continent: 'Asia',
    utcOffset: Duration(hours: 5, minutes: 30),
  ),
  WorldCity(
    id: 'mumbai',
    name: 'Mumbai',
    country: 'India',
    continent: 'Asia',
    utcOffset: Duration(hours: 5, minutes: 30),
  ),
  WorldCity(
    id: 'dhaka',
    name: 'Dhaka',
    country: 'Bangladesh',
    continent: 'Asia',
    utcOffset: Duration(hours: 6),
  ),
  WorldCity(
    id: 'karachi',
    name: 'Karachi',
    country: 'Pakistan',
    continent: 'Asia',
    utcOffset: Duration(hours: 5),
  ),
  WorldCity(
    id: 'lahore',
    name: 'Lahore',
    country: 'Pakistan',
    continent: 'Asia',
    utcOffset: Duration(hours: 5),
  ),
  WorldCity(
    id: 'islamabad',
    name: 'Islamabad',
    country: 'Pakistan',
    continent: 'Asia',
    utcOffset: Duration(hours: 5),
  ),
  WorldCity(
    id: 'taipei',
    name: 'Taipei',
    country: 'Taiwan',
    continent: 'Asia',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'hanoi',
    name: 'Hanoi',
    country: 'Vietnam',
    continent: 'Asia',
    utcOffset: Duration(hours: 7),
  ),
  WorldCity(
    id: 'hochiminh',
    name: 'Ho Chi Minh City',
    country: 'Vietnam',
    continent: 'Asia',
    utcOffset: Duration(hours: 7),
  ),
  WorldCity(
    id: 'yangon',
    name: 'Yangon',
    country: 'Myanmar',
    continent: 'Asia',
    utcOffset: Duration(hours: 6, minutes: 30),
  ),
  WorldCity(
    id: 'phnompenh',
    name: 'Phnom Penh',
    country: 'Kamboja',
    continent: 'Asia',
    utcOffset: Duration(hours: 7),
  ),
  WorldCity(
    id: 'colombo',
    name: 'Colombo',
    country: 'Sri Lanka',
    continent: 'Asia',
    utcOffset: Duration(hours: 5, minutes: 30),
  ),
  WorldCity(
    id: 'kathmandu',
    name: 'Kathmandu',
    country: 'Nepal',
    continent: 'Asia',
    utcOffset: Duration(hours: 5, minutes: 45),
  ),
  WorldCity(
    id: 'dubai',
    name: 'Dubai',
    country: 'Uni Emirat Arab',
    continent: 'Asia',
    utcOffset: Duration(hours: 4),
  ),
  WorldCity(
    id: 'riyadh',
    name: 'Riyadh',
    country: 'Arab Saudi',
    continent: 'Asia',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'doha',
    name: 'Doha',
    country: 'Qatar',
    continent: 'Asia',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'kuwaitcity',
    name: 'Kuwait City',
    country: 'Kuwait',
    continent: 'Asia',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'muscat',
    name: 'Muscat',
    country: 'Oman',
    continent: 'Asia',
    utcOffset: Duration(hours: 4),
  ),
  WorldCity(
    id: 'tehran',
    name: 'Teheran',
    country: 'Iran',
    continent: 'Asia',
    utcOffset: Duration(hours: 3, minutes: 30),
  ),

  // ===== EROPA (25) =====
  WorldCity(
    id: 'london',
    name: 'London',
    country: 'Inggris',
    continent: 'Eropa',
    utcOffset: Duration(hours: 0),
  ),
  WorldCity(
    id: 'paris',
    name: 'Paris',
    country: 'Prancis',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'berlin',
    name: 'Berlin',
    country: 'Jerman',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'madrid',
    name: 'Madrid',
    country: 'Spanyol',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'rome',
    name: 'Roma',
    country: 'Italia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'moscow',
    name: 'Moscow',
    country: 'Rusia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'amsterdam',
    name: 'Amsterdam',
    country: 'Belanda',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'brussels',
    name: 'Brussels',
    country: 'Belgia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'vienna',
    name: 'Vienna',
    country: 'Austria',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'prague',
    name: 'Prague',
    country: 'Ceko',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'warsaw',
    name: 'Warsaw',
    country: 'Polandia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'zurich',
    name: 'Zurich',
    country: 'Swiss',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'stockholm',
    name: 'Stockholm',
    country: 'Swedia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'oslo',
    name: 'Oslo',
    country: 'Norwegia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'copenhagen',
    name: 'Copenhagen',
    country: 'Denmark',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'dublin',
    name: 'Dublin',
    country: 'Irlandia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 0),
  ),
  WorldCity(
    id: 'budapest',
    name: 'Budapest',
    country: 'Hungaria',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'athens',
    name: 'Athena',
    country: 'Yunani',
    continent: 'Eropa',
    utcOffset: Duration(hours: 2),
  ),
  WorldCity(
    id: 'lisbon',
    name: 'Lisbon',
    country: 'Portugal',
    continent: 'Eropa',
    utcOffset: Duration(hours: 0),
  ),
  WorldCity(
    id: 'istanbul',
    name: 'Istanbul',
    country: 'Turki',
    continent: 'Eropa',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'helsinki',
    name: 'Helsinki',
    country: 'Finlandia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 2),
  ),
  WorldCity(
    id: 'munich',
    name: 'Munich',
    country: 'Jerman',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'milan',
    name: 'Milan',
    country: 'Italia',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'hamburg',
    name: 'Hamburg',
    country: 'Jerman',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'barcelona',
    name: 'Barcelona',
    country: 'Spanyol',
    continent: 'Eropa',
    utcOffset: Duration(hours: 1),
  ),

  // ===== AMERIKA (23) =====
  WorldCity(
    id: 'newyork',
    name: 'New York',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'losangeles',
    name: 'Los Angeles',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -8),
  ),
  WorldCity(
    id: 'chicago',
    name: 'Chicago',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -6),
  ),
  WorldCity(
    id: 'toronto',
    name: 'Toronto',
    country: 'Kanada',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'vancouver',
    name: 'Vancouver',
    country: 'Kanada',
    continent: 'Amerika',
    utcOffset: Duration(hours: -8),
  ),
  WorldCity(
    id: 'montreal',
    name: 'Montreal',
    country: 'Kanada',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'mexicocity',
    name: 'Mexico City',
    country: 'Meksiko',
    continent: 'Amerika',
    utcOffset: Duration(hours: -6),
  ),
  WorldCity(
    id: 'miami',
    name: 'Miami',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'sanfrancisco',
    name: 'San Francisco',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -8),
  ),
  WorldCity(
    id: 'houston',
    name: 'Houston',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -6),
  ),
  WorldCity(
    id: 'dallas',
    name: 'Dallas',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -6),
  ),
  WorldCity(
    id: 'atlanta',
    name: 'Atlanta',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'seattle',
    name: 'Seattle',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -8),
  ),
  WorldCity(
    id: 'buenosaires',
    name: 'Buenos Aires',
    country: 'Argentina',
    continent: 'Amerika',
    utcOffset: Duration(hours: -3),
  ),
  WorldCity(
    id: 'riodejaneiro',
    name: 'Rio de Janeiro',
    country: 'Brasil',
    continent: 'Amerika',
    utcOffset: Duration(hours: -3),
  ),
  WorldCity(
    id: 'saopaulo',
    name: 'Sao Paulo',
    country: 'Brasil',
    continent: 'Amerika',
    utcOffset: Duration(hours: -3),
  ),
  WorldCity(
    id: 'lima',
    name: 'Lima',
    country: 'Peru',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'bogota',
    name: 'Bogota',
    country: 'Kolombia',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'santiago',
    name: 'Santiago',
    country: 'Chile',
    continent: 'Amerika',
    utcOffset: Duration(hours: -4),
  ),
  WorldCity(
    id: 'caracas',
    name: 'Caracas',
    country: 'Venezuela',
    continent: 'Amerika',
    utcOffset: Duration(hours: -4),
  ),
  WorldCity(
    id: 'philadelphia',
    name: 'Philadelphia',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'boston',
    name: 'Boston',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),
  WorldCity(
    id: 'washingtondc',
    name: 'Washington D.C.',
    country: 'Amerika Serikat',
    continent: 'Amerika',
    utcOffset: Duration(hours: -5),
  ),

  // ===== AFRIKA (12) =====
  WorldCity(
    id: 'capetown',
    name: 'Cape Town',
    country: 'Afrika Selatan',
    continent: 'Afrika',
    utcOffset: Duration(hours: 2),
  ),
  WorldCity(
    id: 'johannesburg',
    name: 'Johannesburg',
    country: 'Afrika Selatan',
    continent: 'Afrika',
    utcOffset: Duration(hours: 2),
  ),
  WorldCity(
    id: 'cairo',
    name: 'Cairo',
    country: 'Mesir',
    continent: 'Afrika',
    utcOffset: Duration(hours: 2),
  ),
  WorldCity(
    id: 'lagos',
    name: 'Lagos',
    country: 'Nigeria',
    continent: 'Afrika',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'nairobi',
    name: 'Nairobi',
    country: 'Kenya',
    continent: 'Afrika',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'casablanca',
    name: 'Casablanca',
    country: 'Maroko',
    continent: 'Afrika',
    utcOffset: Duration(hours: 0),
  ),
  WorldCity(
    id: 'accra',
    name: 'Accra',
    country: 'Ghana',
    continent: 'Afrika',
    utcOffset: Duration(hours: 0),
  ),
  WorldCity(
    id: 'addisababa',
    name: 'Addis Ababa',
    country: 'Ethiopia',
    continent: 'Afrika',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'algiers',
    name: 'Algiers',
    country: 'Aljazair',
    continent: 'Afrika',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'tunis',
    name: 'Tunis',
    country: 'Tunisia',
    continent: 'Afrika',
    utcOffset: Duration(hours: 1),
  ),
  WorldCity(
    id: 'kampala',
    name: 'Kampala',
    country: 'Uganda',
    continent: 'Afrika',
    utcOffset: Duration(hours: 3),
  ),
  WorldCity(
    id: 'daressalaam',
    name: 'Dar es Salaam',
    country: 'Tanzania',
    continent: 'Afrika',
    utcOffset: Duration(hours: 3),
  ),

  // ===== OSEANIA (9) =====
  WorldCity(
    id: 'sydney',
    name: 'Sydney',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 10),
  ),
  WorldCity(
    id: 'melbourne',
    name: 'Melbourne',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 10),
  ),
  WorldCity(
    id: 'brisbane',
    name: 'Brisbane',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 10),
  ),
  WorldCity(
    id: 'perth',
    name: 'Perth',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 8),
  ),
  WorldCity(
    id: 'adelaide',
    name: 'Adelaide',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 9, minutes: 30),
  ),
  WorldCity(
    id: 'canberra',
    name: 'Canberra',
    country: 'Australia',
    continent: 'Oseania',
    utcOffset: Duration(hours: 10),
  ),
  WorldCity(
    id: 'auckland',
    name: 'Auckland',
    country: 'Selandia Baru',
    continent: 'Oseania',
    utcOffset: Duration(hours: 12),
  ),
  WorldCity(
    id: 'wellington',
    name: 'Wellington',
    country: 'Selandia Baru',
    continent: 'Oseania',
    utcOffset: Duration(hours: 12),
  ),
  WorldCity(
    id: 'portmoresby',
    name: 'Port Moresby',
    country: 'Papua Nugini',
    continent: 'Oseania',
    utcOffset: Duration(hours: 10),
  ),
];

// =================== ADD CITY PAGE ===================

class AddCityPage extends StatefulWidget {
  final Set<String> alreadySelectedIds;

  const AddCityPage({Key? key, required this.alreadySelectedIds})
    : super(key: key);

  @override
  State<AddCityPage> createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage>
    with SingleTickerProviderStateMixin {
  String _query = '';
  String _selectedContinent = 'Semua';

  late AnimationController _globeController;

  static const _continents = [
    'Semua',
    'Asia',
    'Eropa',
    'Amerika',
    'Afrika',
    'Oseania',
  ];

  @override
  void initState() {
    super.initState();
    _globeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _globeController.dispose();
    super.dispose();
  }

  List<WorldCity> _filteredCities() {
    return allWorldCities.where((city) {
      if (widget.alreadySelectedIds.contains(city.id)) return false;

      if (_selectedContinent != 'Semua' &&
          city.continent != _selectedContinent) {
        return false;
      }

      if (_query.isEmpty) return true;

      final q = _query.toLowerCase();
      return city.name.toLowerCase().contains(q) ||
          city.country.toLowerCase().contains(q) ||
          city.continent.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCities();

    return Scaffold(
      backgroundColor: const Color(0xFF0B2646),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B2646),
        elevation: 0,
        title: const Text(
          'Tambah kota',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // Globe animasi
          SizedBox(
            height: 190,
            child: Center(
              child: RotationTransition(
                turns: _globeController,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF90CAF9),
                        Color(0xFF1E88E5),
                        Color(0xFF0B2646),
                      ],
                      center: Alignment(0, -0.2),
                      radius: 0.9,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Positioned(
                        left: 40,
                        top: 40,
                        child: Icon(Icons.landscape, color: Colors.white24),
                      ),
                      Positioned(
                        right: 35,
                        bottom: 45,
                        child: Icon(Icons.landscape, color: Colors.white24),
                      ),
                      Text('🌏', style: TextStyle(fontSize: 52)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                hintText: 'Cari kota atau negara',
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() => _query = value);
              },
            ),
          ),

          const SizedBox(height: 8),

          // Filter benua
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final label = _continents[index];
                final selected = label == _selectedContinent;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => _selectedContinent = label);
                  },
                  labelStyle: TextStyle(
                    color: selected ? Colors.black : Colors.white,
                  ),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.white10,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _continents.length,
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0E0E0E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: ListView.builder(
                  key: ValueKey('list_${_selectedContinent}_$_query'),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final city = filtered[index];
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 20, end: 0),
                      duration: Duration(milliseconds: 150 + index * 20),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, value),
                          child: Opacity(
                            opacity: 1 - (value / 20),
                            child: child,
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          city.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${city.country} • ${city.continent}',
                          style: const TextStyle(color: Colors.white60),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(city);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =================== LAYER 4: STOPWATCH ===================
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      setState(() {
        _milliseconds += 10;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pause() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int ms) {
    final hundreds = (ms / 10).floor() % 100;
    final seconds = (ms / 1000).floor() % 60;
    final minutes = (ms / 60000).floor();

    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(minutes)}:${two(seconds)}:${two(hundreds)}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _formatTime(_milliseconds);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(120),
            ),
            elevation: 8,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                gradient: const SweepGradient(
                  colors: [
                    Color(0xFF3F51B5),
                    Color(0xFF9C27B0),
                    Color(0xFF3F51B5),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    color: const Color(0xFF11111A),
                    borderRadius: BorderRadius.circular(120),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    timeText,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: _isRunning ? _pause : _start,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: Text(_isRunning ? 'Pause' : 'Mulai'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =================== LAYER 5: TIMER ===================
class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // Controller untuk picker
  late FixedExtentScrollController _hourCtrl;
  late FixedExtentScrollController _minCtrl;
  late FixedExtentScrollController _secCtrl;

  // Nilai terpilih
  int _h = 0;
  int _m = 0;
  int _s = 0;

  // Waktu yang sedang berjalan (dalam detik)
  int _totalSeconds = 0;

  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _hourCtrl = FixedExtentScrollController();
    _minCtrl = FixedExtentScrollController();
    _secCtrl = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _hourCtrl.dispose();
    _minCtrl.dispose();
    _secCtrl.dispose();
    super.dispose();
  }

  void _startTimer() {
    _totalSeconds = _h * 3600 + _m * 60 + _s;

    if (_totalSeconds == 0) {
      // Kalau 0 detik, tidak jalan apa-apa
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Waktu harus lebih dari 0 detik.')),
      );
      return;
    }

    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_totalSeconds <= 1) {
        t.cancel();
        setState(() => _isRunning = false);
      }

      setState(() => _totalSeconds--);
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _totalSeconds = 0;
    });
  }

  /// Widget untuk 1 kolom picker (jam / menit / detik)
  Widget _buildPicker({
    required int max,
    required FixedExtentScrollController controller,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      height: 150,
      width: 90,
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: 40,
        looping: true,
        onSelectedItemChanged: onChanged,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.05),
          ),
        ),
        children: List.generate(
          max,
          (i) => Center(
            child: Text(
              i.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Tombol bulat untuk quick set (10 / 15 / 30 detik)
  Widget _quickButton(String label, int seconds) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        // Hitung jam, menit, detik dari detik total
        _h = seconds ~/ 3600;
        _m = (seconds % 3600) ~/ 60;
        _s = seconds % 60;

        _hourCtrl.jumpToItem(_h);
        _minCtrl.jumpToItem(_m);
        _secCtrl.jumpToItem(_s);

        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Text(label, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Nilai yang ditampilkan di angka besar atas
    final int showH = _totalSeconds ~/ 3600;
    final int showM = (_totalSeconds % 3600) ~/ 60;
    final int showS = _totalSeconds % 60;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Timer',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // ======= DISPLAY WAKTU BESAR =======
            Text(
              '${showH.toString().padLeft(2, '0')} : '
              '${showM.toString().padLeft(2, '0')} : '
              '${showS.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // ======= LABEL JAM / MENIT / DETIK =======
            if (!_isRunning)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 90,
                    child: Center(
                      child: Text(
                        'Jam',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Center(
                      child: Text(
                        'Menit',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: Center(
                      child: Text(
                        'Detik',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 8),

            // ======= PICKER TIGA KOLOM =======
            if (!_isRunning)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPicker(
                    max: 100,
                    controller: _hourCtrl,
                    onChanged: (v) => _h = v,
                  ),
                  _buildPicker(
                    max: 60,
                    controller: _minCtrl,
                    onChanged: (v) => _m = v,
                  ),
                  _buildPicker(
                    max: 60,
                    controller: _secCtrl,
                    onChanged: (v) => _s = v,
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // ======= TOMBOL QUICK DURASI =======
            if (!_isRunning)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _quickButton('00.10.00', 10),
                  const SizedBox(width: 16),
                  _quickButton('00.15.00', 15),
                  const SizedBox(width: 16),
                  _quickButton('00.30.00', 30),
                ],
              ),

            const SizedBox(height: 32),

            // ======= TOMBOL MULAI / RESET =======
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol reset
                if (_isRunning || _totalSeconds > 0)
                  OutlinedButton(
                    onPressed: _resetTimer,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.4)),
                      foregroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Reset'),
                  ),

                if (_isRunning || _totalSeconds > 0) const SizedBox(width: 16),

                // Tombol mulai
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 60,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _isRunning ? 'Berjalan...' : 'Mulai',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
