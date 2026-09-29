# PRD — JEJAK SAKU INTERACTIVE MOBILE WIDGET

## 1. Product Overview

**Jejak Saku Mobile Widget** adalah widget interaktif untuk membantu pengguna melakukan aktivitas PKL dengan cepat langsung dari home screen.

Widget bukan sekadar shortcut dan bukan mini-dashboard.

> **Widget = Quick Action + Quick Information + Quick Chat**

---

## 2. Goals

Widget harus memungkinkan pengguna:

* melihat reminder secara cepat
* melihat tanggal/hari
* mencatat dokumentasi
* mengatur status kehadiran
* membuka floating chat
* berinteraksi dengan Companion/Tamagotchi
* melihat informasi ringan seperti status task/sync

Semua data harus terhubung dengan aplikasi Jejak Saku.

---

## 3. Widget Sizes

Widget harus responsive terhadap ukuran yang tersedia.

### 1x1

Menampilkan:

* Companion
* status singkat
* akses Chat

### 2x1

Menampilkan:

* Companion
* Divider
* Reminder
* Date
* Documentation
* Attendance
* Chat

### 2x2 / ukuran lebih besar

Dapat menampilkan:

* Companion
* Reminder
* Task progress
* Next schedule
* Quick Actions
* Chat

Jangan memaksakan seluruh komponen pada ukuran kecil.

---

## 4. Visual Specification

### Main Container

```text
Background: #BECFD8
Radius: 25px
Shadow: Soft
Border: subtle white
```

### Companion

Lingkaran di sisi kiri yang nantinya berisi karakter robot/Tamagotchi.

Companion harus mendukung state:

* Idle
* Happy
* Reminder
* Working
* Documentation
* Learning
* Syncing
* Offline
* Success

Asset robot harus mudah diganti tanpa mengubah layout widget.

### Divider

Vertical line sebagai separator visual.

Tidak memiliki fungsi interaksi.

### Reminder

```text
Background: #6D8A9A
Radius: 18px
Stroke: thin white
Shadow: subtle
```

Menampilkan reminder terdekat sebelum menjadi system notification.

### Date

```text
Background: #919FAC
Radius: 12px
```

Dapat menampilkan:

* tanggal
* hari
* "Hari ini"
* "Besok"

Informasi dapat berubah secara realtime.

### Documentation

```text
Background: #AC3F42
Radius: 12px
```

Tap:

`Widget → Camera → Capture → Save → Sync`

### Attendance

```text
Background: #6D8A9A
Radius: 12px
```

Pilihan:

* Masuk
* Izin
* Sakit
* Libur (optional)

### Chat

Vertical pill berwarna cream/yellow.

Tap:

`Widget → Floating Chat`

---

## 5. Floating Chat

Chat muncul sebagai **temporary floating workspace**, bukan halaman aplikasi biasa.

Fungsi:

* membaca history
* mengirim pesan
* menjalankan slash command
* melakukan quick action
* melihat hasil command

Chat harus dapat ditutup tanpa kehilangan pesan persistent.

---

## 6. Message Persistence

### Normal message

Contoh:

> "Hari ini saya memperbaiki responsive navbar."

Harus:

* tersimpan
* masuk history
* tetap tersedia setelah chat ditutup

### Slash command

Contoh:

```text
/status
/jadwal
/dokumentasi
/task
/belajar
/catatan
```

Command UI bersifat **ephemeral**.

Saat chat ditutup:

* command/result UI dapat hilang
* **data yang dihasilkan command tidak boleh hilang**

Contoh:

```text
/status
↓
3/5 Task selesai
↓
Close Chat
↓
/status hilang
```

Tetapi data Task tetap tersimpan.

**Prinsip:**

> UI ephemeral ≠ data ephemeral.

---

## 7. Documentation

Dokumentasi menggunakan:

**Google Drive sebagai binary storage.**

Supabase menyimpan metadata:

```text
id
fileName
driveFileId
driveUrl
fileType
fileSize
capturedAt
taskId
activityId
syncStatus
```

Tidak boleh menggunakan fake URL atau simulated upload.

---

## 8. Data & Sync

Architecture:

```text
Widget
   ↓
Local Database
   ↓
Sync Queue
   ↓
Supabase
```

Documentation:

```text
Camera
   ↓
Local Storage
   ↓
Google Drive
   ↓
Supabase Metadata
```

Harus mendukung:

* offline
* retry
* reconnect
* sync status
* realtime update

---

## 9. Core UX

### Documentation

```text
Widget
→ Documentation
→ Camera
→ Preview
→ Save
→ Sync
```

### Attendance

```text
Widget
→ Attendance
→ Select Status
→ Save
→ Sync
```

### Chat

```text
Widget
→ Chat
→ Floating Chat
→ Message / Slash Command
```

### Reminder

```text
Reminder Created
→ Widget
→ Approaching Time
→ Notification
→ Complete/Dismiss
```

---

## 10. Technical Principles

Gunakan architecture modular.

Pisahkan:

* UI
* domain logic
* repository
* local storage
* remote API
* sync
* widget integration

Jangan hardcode:

* task
* reminder
* attendance
* documentation
* chat history
* sync status

Jika belum ada data, gunakan empty state yang jujur.

---

## 11. Non-Goals

Widget **tidak** boleh menjadi:

* mini dashboard
* AI chatbot generik
* full application
* launcher dengan terlalu banyak tombol
* tempat mengedit seluruh data Jejak Saku

---

## 12. Success Criteria

Fitur dianggap berhasil jika:

* [ ] Widget responsive pada berbagai ukuran
* [ ] Visual mengikuti design reference
* [ ] Companion architecture siap menerima asset robot
* [ ] Reminder realtime
* [ ] Date/day realtime
* [ ] Documentation dapat dimulai dari widget
* [ ] Attendance dapat diubah dari widget
* [ ] Chat membuka floating interface
* [ ] Normal messages persistent
* [ ] Slash commands ephemeral
* [ ] Data command tetap persistent
* [ ] Offline-first
* [ ] Supabase realtime
* [ ] Google Drive documentation storage
* [ ] Tidak ada fake/mock data pada production flow
* [ ] Tidak ada overflow

---

## 13. Product Principle

> **Widget = Quick Action**
> **Floating Chat = Quick Interaction**
> **Mobile App = Full Management**
> **Desktop = Command Center**

Tujuan akhirnya adalah membuat Jejak Saku terasa seperti **companion kecil yang selalu tersedia di home screen**, bukan sekadar widget biasa.

