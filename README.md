TUGAS MEMBUAT APLIKASI FLUTTER (MINIMAAL 5 LAYER)

NAMA MAHASISWA PEMBUAT : Ahmad Na'im Bashiroh
NIM : 14022300034
MATA KULIAH : PEMROGRAMAN MOBILE
DOSEN PENGAMPU : Faisal Akhmad S.Kom., M.Kom.
PRODI SISTEM INFORMASI
FAKULTAS ILMU KOMPUTER
UNIVERSITAS BINA BANGSA


📱 Aplikasi Jam — Flutter
Aplikasi ini adalah aplikasi jam multifungsi berbasis Flutter, dengan 5 fitur utama:
1. Beranda
2. Alarm
3. Jam Dunia
4. Stopwatch
5. Timer
Aplikasi ini dirancang dengan UI modern, tampilan gelap (dark mode), animasi halus, dan pengalaman pengguna yang mudah.

🧭 Navigasi Layar
Aplikasi menggunakan tab bar (BottomNavigationBar) dengan 5 tab utama:
- 🏠 Beranda
- ⏰ Alarm
- 🌍 Jam Dunia
- ⏱ Stopwatch
- ⏲ Pewaktu
Setiap fitur berada di layer masing-masing (Layer 1–5).

🟦 Layer 1 — Beranda
Layar pertama yang muncul saat aplikasi dibuka.
Fitur Beranda:
1. Menampilkan salam dinamis (Selamat pagi/siang/sore/malam).
2. Menampilkan tanggal lengkap (contoh: Jumat, 15 Januari 2025).
3. Kartu jam besar yang menunjukkan waktu lokal real-time, diperbarui setiap detik.
4. Quick Access:
   - Alarm
   - Jam Dunia
   - Stopwatch
   - Timer
UI dibuat modern dengan:
1. Background gradient
2. Dekorasi lingkaran blur
3. Kartu fitur dengan ikon asli alarm/clock
Beranda berfungsi sebagai pusat informasi waktu dan shortcut ke semua fitur.

🟩 Layer 2 — Alarm
Layar untuk membuat alarm harian.
Fitur Alarm:
1. Tambah alarm menggunakan ikon + di pojok kanan atas.
2. Pilih jam dan menit menggunakan time picker.
3. Pilih hari berulang (Senin–Minggu).
Pilih:
    - Nama alarm
    - Nada alarm
    - Getar (vibrate)
    - Snooze (berapa kali & berapa menit)
4. Toggle ON/OFF alarm.
Alarm belum memakai background notification (karena itu butuh backend seperti WorkManager), namun alarm dapat bekerja secara simulasi di dalam aplikasi.

🟨 Layer 3 — Jam Dunia
Menampilkan waktu dari berbagai kota besar dunia.
Fitur Jam Dunia:
1. Menampilkan waktu lokal dan perbedaan jam dengan waktu pengguna.
2. Kota ditampilkan dalam kartu elegan.
3. Tambah kota dengan tombol +.
4. Halaman tambah kota berisi:
    - 100 kota besar dunia
    - Search bar
    - Filter benua
    - Globe view (animasi bola dunia)
    - Transisi animasi saat memilih kota
Jam dunia diupdate real-time (tiap detik) menggunakan UTC.

🟧 Layer 4 — Stopwatch
Stopwatch modern dengan akurasi tinggi.
Fitur Stopwatch:
1. Mulai / Berhenti / Reset
2. Lap time (opsional dapat ditambahkan)
3. Desain minimalis
4. Timer berjalan presisi menggunakan Timer.periodic.
5. Angka tampil besar dan mudah dibaca.
Stopwatch tetap berjalan selama aplikasi aktif di layar.

🟥 Layer 5 — Timer
Timer untuk menghitung mundur.
Fitur Timer:
1. Pilih durasi dengan:
   - Quick set (10 detik, 15 detik, 30 detik)
   - Pengaturan manual geser atas–bawah (seperti UI Samsung)
2. Start / Pause / Reset
3. Animasi countdown mulus
4. Pesan saat waktu hampir habis
Timer belum memiliki background notification (perlu backend), tetapi countdown berjalan sempurna saat aplikasi terbuka.

🛠 Teknologi yang Digunakan
1. Flutter (Dart)
2. tatefulWidget & Timer
3. BottomNavigationBar
4. Animasi bawaan Flutter
5. Custom UI dengan:
   - LinearGradient
   - RadialGradient
   - Stack dekoratif
   - Container + Card
6. Struktur kode bersih & modular

📦 Cara Menjalankan Aplikasi
1. Install Flutter SDK
2. Clone project
3. Jalankan di terminal:
   flutter pub get
   flutter run

🎨 Desain UI
Aplikasi menggunakan desain:
1. Dark theme
2. Gradient modern
3. Icon rounded
4. Style modern seperti aplikasi jam bawaan Samsung/Google
Konsisten rapi pada setiap layer.

🚀 Rencana Pengembangan
Fitur masa depan yang bisa ditambahkan:
1. Alarm dengan notifikasi background (WorkManager)
2. Widget home screen
3. Tema terang/gelap otomatis
4. Suara alarm custom
5. Simpan kota/alarm ke penyimpanan lokal (SharedPreferences)

❤️ Kesimpulan
Aplikasi ini adalah aplikasi jam yang lengkap dengan 5 fitur utama.
Dibuat dengan Flutter dan UI modern yang halus, cocok sebagai project pemula hingga menengah yang ingin memahami:
- state management dasar
- timer
- animasi
- UI/UX Flutter
- navigasi multi-layer
