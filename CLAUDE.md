# MASTER PROMPT

# JEJAK SAKU — INTERACTIVE MOBILE WIDGET

## ROLE

Bertindak sebagai Senior Product Designer, Mobile UX Engineer, dan Flutter Engineer.

Bangun fitur **Jejak Saku Mobile Interactive Widget** yang menjadi bagian dari ekosistem Jejak Saku.

Jejak Saku adalah aplikasi produktivitas PKL dengan konsep:

* Desktop = Command Center
* Mobile = Field Companion
* Mobile Widget = Quick Companion

Mobile widget bukan widget informasi pasif.

Widget harus menjadi **interactive productivity surface** yang memungkinkan pengguna melakukan beberapa tindakan langsung dari home screen tanpa harus selalu membuka aplikasi penuh.

Namun widget juga tidak boleh berubah menjadi mini-dashboard yang terlalu kompleks.

Prinsip utama:

> **See quickly. Act quickly. Chat quickly.**

---

# 1. REFERENSI DESAIN

Gunakan gambar desain yang diberikan user sebagai **referensi utama visual dan layout**.

Pertahankan karakter visual dari desain tersebut:

* rounded container besar
* soft blue-gray
* cream/yellow accent
* muted red documentation button
* subtle white stroke
* soft shadow
* clean spacing
* minimal typography
* playful tetapi tetap professional
* sedikit retro/personal karena elemen robot/tamagotchi
* tidak terlihat seperti dashboard enterprise
* tidak terlihat seperti AI chatbot generik

Jangan mengubah konsep menjadi desain baru yang tidak berhubungan dengan referensi.

Boleh melakukan improvement pada:

* alignment
* spacing
* sizing
* responsive behavior
* typography
* accessibility
* interaction feedback
* hierarchy
* platform compatibility

Tetapi identitas visual utama harus tetap dipertahankan.

---

# 2. CORE CONCEPT

Widget Jejak Saku memiliki beberapa ukuran.

Ukuran ideal:

* 1x1
* 2x1
* dan ukuran lain jika platform memungkinkan

Jangan menganggap ukuran tersebut sebagai ukuran pixel absolut.

Gunakan sistem responsive berdasarkan:

```text
available width
available height
platform widget constraints
device density
```

Jika platform tidak memungkinkan ukuran tertentu, gunakan ukuran terdekat yang tersedia.

Jangan memaksakan layout sampai overflow.

---

# 3. MAIN WIDGET CONTAINER

Container utama menggunakan:

```text
background:
#BECFD8

border radius:
25

shadow:
soft / subtle

border:
optional thin translucent white
```

Widget harus terlihat seperti satu objek yang utuh.

Jangan membuat terlalu banyak card kecil di dalam widget.

Visual hierarchy harus berasal dari:

* spacing
* shape
* typography
* contrast
* positioning

bukan dari banyak warna.

---

# 4. RESPONSIVE WIDGET SIZES

## 1x1

Jika widget sangat kecil, prioritaskan:

1. Robot / Jejak Saku avatar
2. status kecil
3. tap interaction

Contoh:

```text
┌──────────────┐
│              │
│    ◉ 🤖      │
│              │
│ Jejak Saku   │
└──────────────┘
```

Pada ukuran ini jangan memaksakan semua tombol.

Widget harus tetap terlihat clean.

Tap widget:

→ buka Floating Chat / Quick Companion.

---

# 5. 2x1 MAIN WIDGET

Ini adalah bentuk utama yang mengikuti referensi desain user.

Struktur:

```text
┌───────────────────────────────────────────┐
│                                           │
│   ROBOT     │   REMINDER                  │ CHAT
│             │                             │
│             │  20/04  DOCUMENT  MASUK     │
│                                           │
└───────────────────────────────────────────┘
```

Elemen:

1. Robot / interactive companion
2. Vertical separator
3. Reminder
4. Date/status
5. Documentation
6. Attendance dropdown
7. Vertical Chat button

---

# 6. ROBOT / TAMAGOTCHI AREA

Lingkaran di sisi kiri bukan sekadar avatar.

Ini adalah:

> **Jejak Saku Companion**

Robot akan menjadi karakter kecil yang dapat berinteraksi dengan user.

Saat ini design robot belum final.

Maka:

JANGAN membuat robot final secara permanen.

Gunakan component abstraction:

```text
CompanionWidget
```

sehingga asset robot dapat diganti nanti tanpa mengubah struktur widget.

---

# 7. COMPANION BEHAVIOR

Robot dapat berubah berdasarkan context.

Contoh state:

```text
normal
happy
working
waiting
reminder
documentation
learning
sleeping
offline
synced
```

Contoh:

Saat tidak ada aktivitas:

```text
🙂
```

Saat task selesai:

```text
✓
```

Saat ada reminder:

```text
!
```

Saat dokumentasi berhasil:

```text
📷 ✓
```

Saat offline:

```text
•
```

Tetapi jangan menggunakan emoji sebagai final implementation jika nantinya tersedia asset/animation robot.

Buat state system agar asset dapat diganti kemudian.

---

# 8. COMPANION AS INFORMATION SURFACE

Robot juga dapat berubah fungsi menjadi informasi ringan.

Contoh:

```text
08:30
```

atau:

```text
3/5 Task
```

atau:

```text
Next:
14:00
```

atau:

```text
Good morning
```

atau:

```text
2 reminders
```

Perubahan harus contextual.

Jangan mengubah robot menjadi ticker yang terus bergerak.

---

# 9. REALTIME COMPANION

Companion dapat menampilkan informasi realtime berdasarkan data aplikasi.

Contoh:

```text
Current time
Next schedule
Reminder
Sync status
Task completion
Learning session
Documentation state
```

Gunakan data nyata.

Jangan gunakan:

* random text
* fake status
* hardcoded time
* fake task

Jika belum ada data:

```text
—
```

atau empty state yang sesuai.

---

# 10. VERTICAL SEPARATOR

Di antara Companion dan information/action area terdapat garis vertical.

Fungsi:

> hanya sebagai visual separator.

Style:

```text
thin
white / translucent
subtle
```

Jangan memberikan interaction pada separator.

Jangan menjadikannya button.

---

# 11. REMINDER COMPONENT

Reminder menggunakan rounded rectangle.

Style:

```text
background:
#6D8A9A

borderRadius:
18

stroke:
thin white

shadow:
subtle
```

Reminder berfungsi sebagai:

> **pre-notification reminder surface**

Artinya reminder yang belum waktunya menjadi system notification dapat terlebih dahulu muncul di widget.

Contoh:

```text
┌─────────────────────────────┐
│ 🔔 Dokumentasi project      │
└─────────────────────────────┘
```

---

# 12. REMINDER BEHAVIOR

Reminder memiliki lifecycle:

```text
Created
↓
Scheduled
↓
Visible in Widget
↓
Approaching Time
↓
System Notification
↓
Completed / Dismissed
```

Widget harus menampilkan reminder terdekat atau reminder yang relevan.

Jika terdapat banyak reminder:

prioritaskan:

1. reminder terdekat
2. reminder overdue
3. reminder penting

Jangan menampilkan seluruh reminder sekaligus.

---

# 13. REMINDER REALTIME

Jika reminder berubah di aplikasi:

```text
Mobile App
↓
Local Database
↓
Widget State
```

widget harus memperbarui data.

Jika backend menggunakan realtime:

```text
Supabase
↓
Realtime Event
↓
Local State
↓
Widget
```

Jangan membuat widget bergantung pada network request setiap kali ditampilkan.

Gunakan local cached state terlebih dahulu.

---

# 14. DATE / DAY COMPONENT

Tanggal menggunakan rounded rectangle.

Style:

```text
background:
#919FAC

borderRadius:
12
```

Contoh:

```text
20/04
```

Tetapi component ini bersifat dynamic.

Pada waktu tertentu dapat berubah menjadi:

```text
Senin
```

atau:

```text
Hari ini
```

atau:

```text
Besok
```

sesuai konteks.

---

# 15. REALTIME DATE TRANSITION

Tanggal dapat berubah berdasarkan realtime.

Contoh:

```text
20/04
↓
Senin
↓
20/04
```

Jika menggunakan rotating information:

pastikan perubahan tidak mengganggu.

Gunakan transition sederhana.

Tidak perlu animasi berlebihan.

Alternatif yang lebih aman:

```text
Tanggal
→
Hari
```

berganti setiap beberapa detik secara subtle.

Jangan membuat perubahan terlalu cepat.

---

# 16. DOCUMENTATION BUTTON

Documentation menggunakan:

```text
background:
#AC3F42

borderRadius:
12
```

Button ini adalah **quick capture action**.

Ketika ditekan:

```text
Widget
↓
Camera
↓
Capture
↓
Preview
↓
Save
↓
Jejak Saku
```

Jika platform mengizinkan direct camera invocation dari widget, gunakan native capability tersebut.

Jika tidak:

```text
Widget
↓
Open Jejak Saku
↓
Camera automatically opened
```

Jangan membuat UX yang terlihat seolah camera terbuka langsung jika platform sebenarnya tidak mendukungnya.

---

# 17. DOCUMENTATION FLOW

User mengambil foto.

Setelah foto:

```text
Preview
```

Kemudian:

```text
Optional description
Optional task
Optional activity
```

Lalu:

```text
Save Documentation
```

Data:

```text
photo
timestamp
taskId
activityId
description
syncStatus
```

---

# 18. DOCUMENTATION STORAGE

Binary file:

> Google Drive

Metadata:

> Supabase

Jangan menyimpan foto/video binary ke database Supabase.

Metadata contoh:

```text
id
projectId
taskId
activityId
fileName
driveFileId
driveUrl
fileType
fileSize
capturedAt
description
createdAt
updatedAt
syncStatus
```

---

# 19. ATTENDANCE DROPDOWN

Attendance component menggunakan:

```text
background:
#6D8A9A

borderRadius:
12
```

Isi:

```text
Masuk
Izin
Sakit
```

Jika diperlukan dapat diperluas menjadi:

```text
Masuk
Izin
Sakit
Libur
```

Tetapi jangan menambahkan status yang tidak diperlukan.

---

# 20. ATTENDANCE INTERACTION

Ketika dropdown ditekan:

```text
Masuk
Izin
Sakit
```

Tampilkan compact selection.

Setelah dipilih:

```text
selected status
```

Data harus benar-benar tersimpan.

Jangan hanya mengubah visual widget.

Flow:

```text
Widget
↓
Attendance selection
↓
Local DB
↓
Sync Queue
↓
Supabase
```

---

# 21. CHAT BUTTON

Bagian vertical berwarna cream/yellow adalah:

> **Chat**

Style harus mengikuti referensi.

Bukan sekadar membuka full app.

Ketika ditekan:

```text
Widget
↓
Floating Chat
```

Floating Chat harus terasa seperti layar/bubble yang muncul di atas konteks saat ini.

---

# 22. FLOATING CHAT CONCEPT

Floating Chat bukan browser page.

Bukan full-screen navigation.

Bukan dashboard.

Bukan popup alert.

Gunakan konsep:

> **temporary conversational workspace**

Contoh:

```text
┌──────────────────────────┐
│ Jejak Saku          ×    │
├──────────────────────────┤
│                          │
│ / Jadwal                 │
│                          │
│ Hari ini                 │
│ 14:00 Dokumentasi       │
│                          │
│ ┌──────────────────────┐ │
│ │ Ketik pesan...    ➤ │ │
│ └──────────────────────┘ │
└──────────────────────────┘
```

Background aplikasi/home screen dapat tetap terlihat secara subtle.

---

# 23. CHAT UI BEHAVIOR

Chat memiliki dua jenis message:

## NORMAL MESSAGE

Contoh:

```text
Hari ini saya memperbaiki responsive navbar.
```

Message ini:

* tampil di chat
* tersimpan di history
* tetap ada setelah floating chat ditutup
* dapat dibuka kembali
* dapat disinkronkan
* memiliki timestamp

---

# 24. SLASH MESSAGE

Jika user mengetik:

```text
/
```

munculkan command menu.

Contoh:

```text
/jadwal
/reminder
/aktivitas
/belajar
/status
/dokumentasi
/task
/catatan
```

Slash command adalah:

> temporary interaction command

bukan percakapan biasa.

---

# 25. SLASH COMMAND LIFECYCLE

Contoh:

```text
User
↓
/status
↓
Jejak Saku menampilkan status
↓
User menutup floating chat
↓
Command UI tidak muncul lagi
```

Namun:

> data hasil command TIDAK hilang.

Contoh `/status` menghasilkan:

```text
3/5 Task selesai
2 Reminder
4 Documentation
1 Learning Session
```

Informasi tersebut tetap berasal dari database.

Yang bersifat ephemeral hanyalah:

```text
command message UI
```

Bukan:

```text
underlying application data
```

---

# 26. IMPORTANT DATA RULE

Pisahkan:

### UI Message

dan

### Application Data

Contoh:

```text
/status
```

boleh:

```text
isPersistent = false
```

Tetapi:

```text
Task
Reminder
Documentation
LearningSession
Attendance
```

tetap:

```text
persisted = true
```

---

# 27. NORMAL CHAT PERSISTENCE

Semua pesan normal:

```text
isPersistent = true
```

Contoh:

```text
Hari ini saya belajar Flutter.
```

Setelah floating chat ditutup:

```text
message tetap tersimpan
```

Ketika chat dibuka kembali:

```text
message muncul kembali
```

---

# 28. CHAT DATA MODEL

Gunakan model:

```text
ChatMessage

id
conversationId
sender
content
type
createdAt
isPersistent
metadata
syncStatus
```

Message type:

```text
user
assistant
system
command
result
```

---

# 29. EPHEMERAL COMMAND MODEL

Untuk slash command:

```text
type = command
isPersistent = false
```

Untuk result yang hanya bersifat temporary:

```text
type = result
isPersistent = false
```

Tetapi jika result menghasilkan application data:

data tersebut harus masuk entity masing-masing.

Contoh:

```text
/dokumentasi
↓
photo captured
↓
Documentation entity
↓
persisted
```

Chat command dapat hilang.

Documentation tidak.

---

# 30. COMMAND AUTOCOMPLETE

Saat user mengetik:

```text
/
```

tampilkan:

```text
┌─────────────────────────┐
│ / Jadwal                │
│ / Reminder              │
│ / Aktivitas             │
│ / Belajar               │
│ / Status                │
│ / Dokumentasi           │
│ / Task                  │
│ / Catatan               │
└─────────────────────────┘
```

Filtering realtime:

```text
/b
```

menjadi:

```text
/Belajar
```

---

# 31. CHAT QUICK COMMAND RESULT

Result jangan selalu berupa text panjang.

Gunakan compact result card.

Contoh:

```text
/status

┌─────────────────────────┐
│ Hari ini                │
│                         │
│ ✓ 3 Task               │
│ ○ 2 Task tersisa       │
│                         │
│ 📷 4 Dokumentasi       │
│ 📚 1 Learning Session  │
└─────────────────────────┘
```

Result command tetap minimal.

---

# 32. CHAT HISTORY

History hanya menyimpan:

* normal conversation
* meaningful assistant response
* persistent interaction

Jangan menyimpan seluruh temporary command UI jika tidak diperlukan.

Contoh:

```text
Normal:
"Hari ini saya belajar Flutter."
↓
SAVE

Command:
/status
↓
DO NOT SAVE COMMAND UI

Result:
3/5 Task
↓
DO NOT NEED TO SAVE AS CHAT MESSAGE

Underlying task data:
SAVE
```

---

# 33. CLOSING FLOATING CHAT

Ketika user menekan `×`, swipe down, atau close:

Jika normal message:

```text
KEEP
```

Jika slash command:

```text
REMOVE FROM CHAT VIEW
```

Tetapi application data:

```text
KEEP
```

Jangan menghapus database hanya karena command UI ditutup.

---

# 34. CHAT REOPEN

Ketika user membuka Chat lagi:

Tampilkan:

```text
persistent history
```

Jangan tampilkan:

```text
previous ephemeral slash command
```

kecuali command tersebut memang perlu ditampilkan sebagai state aktif.

---

# 35. QUICK CHAT FROM WIDGET

Jika user mengetuk:

```text
Chat
```

Floating Chat dibuka dengan:

```text
input autofocus
```

Jika user mengetuk:

```text
Reminder
```

Floating Chat dapat dibuka langsung pada context reminder.

Jika user mengetuk:

```text
Documentation
```

langsung masuk documentation flow.

Widget harus memahami context.

---

# 36. WIDGET ACTIONS

Action utama:

```text
Chat
Documentation
Attendance
Reminder
Companion
```

Jangan menambahkan puluhan button.

Widget bukan launcher aplikasi.

---

# 37. COMPANION CONTEXTUAL RESPONSE

Companion dapat merespons event.

Contoh:

Documentation berhasil:

```text
Companion:
happy
```

Reminder mendekati waktunya:

```text
Companion:
alert
```

Tidak ada internet:

```text
Companion:
offline
```

Sync selesai:

```text
Companion:
success
```

Ini harus menjadi bagian dari future-ready state system.

---

# 38. COLOR SYSTEM

Gunakan warna yang sudah ditentukan:

```text
Widget:
#BECFD8

Reminder:
#6D8A9A

Date:
#919FAC

Documentation:
#AC3F42
```

Attendance:

```text
#6D8A9A
```

Chat:

gunakan cream/yellow dari desain referensi.

Namun semua warna harus diletakkan pada centralized theme:

```text
AppColors.widgetBackground
AppColors.reminder
AppColors.date
AppColors.documentation
AppColors.attendance
AppColors.chat
```

Jangan hardcode warna di setiap widget component.

---

# 39. SHADOW

Gunakan shadow yang lembut.

Tujuan shadow:

> memberikan depth.

Bukan:

> membuat neumorphism berat.

Hindari excessive blur.

---

# 40. BORDER

Widget utama:

```text
radius: 25
```

Reminder:

```text
radius: 18
white thin stroke
```

Tanggal:

```text
radius: 12
```

Documentation:

```text
radius: 12
```

Attendance:

```text
radius: 12
```

Chat:

gunakan rounded vertical pill sesuai desain.

---

# 41. TYPOGRAPHY

Gunakan typography yang sederhana.

Prefer:

```text
Inter
Manrope
Plus Jakarta Sans
Geist
```

Jangan menggunakan font dekoratif.

Widget text harus terbaca dalam ukuran kecil.

---

# 42. RESPONSIVE LAYOUT RULE

Jangan membuat layout berdasarkan:

```text
fixed pixel positions
```

Gunakan:

```text
constraints
flex
expanded
fitted
responsive breakpoints
adaptive sizing
```

Widget harus tetap usable ketika:

* ukuran widget berbeda
* font size berubah
* device berbeda
* aspect ratio berbeda

---

# 43. NO OVERFLOW

WAJIB melakukan layout audit.

Periksa:

```text
RenderFlex overflow
text overflow
clipped content
button overflow
keyboard overlap
safe area
widget boundary
```

Tidak boleh ada overflow.

---

# 44. PLATFORM LIMITATIONS

Jangan berasumsi widget dapat melakukan semua hal seperti aplikasi penuh.

Untuk setiap action:

```text
Can widget execute directly?
```

Jika YA:

implementasikan direct action.

Jika TIDAK:

```text
Widget
↓
Open App
↓
Open relevant screen automatically
```

Jangan membuat fake interaction.

---

# 45. LOCAL-FIRST

Widget harus membaca state dari local storage/cache terlebih dahulu.

Architecture:

```text
Widget
↓
Local Widget State
↓
Mobile Repository
↓
Local Database
↓
Sync Queue
↓
Supabase
```

Jangan melakukan network request berat setiap widget dibuka.

---

# 46. OFFLINE BEHAVIOR

Jika offline:

Widget tetap menampilkan:

```text
cached reminder
cached attendance
cached task status
cached chat context
```

Documentation dapat:

```text
capture
↓
local
↓
pending sync
```

Kemudian:

```text
online
↓
Google Drive
↓
Supabase metadata
```

---

# 47. SYNC STATUS

Widget dapat menunjukkan status kecil:

```text
✓ Synced
↻ Syncing
○ Offline
! Sync Failed
```

Status harus berasal dari sistem sync nyata.

Jangan menggunakan fake delay.

---

# 48. GOOGLE DRIVE DOCUMENTATION FLOW

```text
Widget
↓
Camera
↓
Local file
↓
Sync Queue
↓
Google Drive
↓
Drive File ID
↓
Supabase metadata
↓
Realtime update
↓
Desktop
```

Desktop kemudian dapat melihat documentation tersebut.

---

# 49. SUPABASE

Supabase digunakan untuk:

* authentication
* application database
* metadata
* realtime
* sync
* relational data

Google Drive:

* photos
* videos
* attachments
* documentation

Jangan menyimpan binary file di Supabase database.

---

# 50. REALTIME

Jika desktop sedang terbuka:

```text
Mobile Widget
↓
Documentation
↓
Google Drive
↓
Supabase metadata
↓
Realtime
↓
Desktop updates
```

Contoh:

User mengambil foto melalui widget.

Desktop secara otomatis mendapatkan:

```text
New Documentation
```

tanpa input ulang.

---

# 51. ARCHITECTURE

Jika menggunakan Flutter, gunakan struktur modular:

```text
lib/
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
│
├── data/
│   ├── local/
│   ├── remote/
│   └── repositories/
│
├── domain/
│   ├── models/
│   └── services/
│
├── features/
│   ├── widget/
│   ├── chat/
│   ├── documentation/
│   ├── attendance/
│   ├── reminder/
│   └── companion/
│
└── services/
    ├── sync/
    ├── drive/
    └── realtime/
```

Business logic jangan dimasukkan langsung ke widget UI.

---

# 52. WIDGET COMPONENT ARCHITECTURE

Pisahkan:

```text
JejakSakuWidget
├── CompanionCircle
├── WidgetDivider
├── ReminderPill
├── DatePill
├── DocumentationButton
├── AttendanceDropdown
└── ChatPill
```

Chat:

```text
FloatingChat
├── ChatHeader
├── ChatHistory
├── SlashCommandMenu
├── ChatMessage
├── CommandResult
└── ChatComposer
```

---

# 53. FUTURE ROBOT SYSTEM

Robot belum final.

Karena itu jangan mengikat UI dengan satu image.

Gunakan:

```text
CompanionState
```

Contoh:

```text
enum CompanionState {
  idle,
  happy,
  working,
  reminder,
  documentation,
  learning,
  offline,
  syncing,
  success,
}
```

Kemudian:

```text
CompanionRenderer
```

dapat mengganti:

* static image
* animated image
* Lottie
* Rive
* custom Flutter animation

di masa depan.

---

# 54. FUTURE USE OF COMPANION

Companion nantinya dapat menjadi:

* jam
* reminder indicator
* task status
* mood/status
* learning indicator
* sync indicator
* documentation feedback
* greeting

Tetapi jangan implementasikan semuanya sekaligus.

Buat architecture yang siap menerima fitur tersebut.

---

# 55. UX PRIORITY

Prioritas widget:

```text
1. Quick Chat
2. Quick Documentation
3. Reminder
4. Attendance
5. Current Date / Day
6. Companion
7. Lightweight status
```

Semua harus terasa cepat.

---

# 56. WHAT NOT TO DO

JANGAN:

* membuat widget menjadi dashboard
* menambahkan chart
* menambahkan statistik besar
* membuat 10+ button
* menggunakan neon
* menggunakan cyberpunk
* menggunakan excessive glassmorphism
* membuat floating chat seperti ChatGPT clone
* menyimpan semua slash command ke history
* menghapus data database ketika slash command ditutup
* membuat fake Google Drive upload
* menggunakan fake sync
* menggunakan dummy task
* menggunakan hardcoded reminder
* menggunakan hardcoded attendance
* membuat widget overflow
* membuat robot final sebelum asset robot tersedia

---

# 57. EXAMPLE USER FLOW

## FLOW A — CHAT

```text
Home Screen
↓
Jejak Saku Widget
↓
Tap Chat
↓
Floating Chat
↓
User:
"Hari ini saya memperbaiki navbar."
↓
Assistant:
"Mau disimpan sebagai aktivitas?"
↓
User:
"Ya"
↓
Activity saved
↓
Chat message tetap persistent
↓
Close Chat
↓
Reopen Chat
↓
Message masih ada
```

---

# 58. FLOW B — SLASH COMMAND

```text
Widget
↓
Chat
↓
/
↓
/status
↓
Status ditampilkan
↓
User close chat
↓
/status message hilang dari UI
↓
Task / Reminder / Documentation data tetap ada
```

---

# 59. FLOW C — DOCUMENTATION

```text
Widget
↓
Documentation
↓
Camera
↓
Take photo
↓
Preview
↓
Save
↓
Local
↓
Google Drive
↓
Supabase metadata
↓
Desktop realtime update
```

---

# 60. FLOW D — ATTENDANCE

```text
Widget
↓
Masuk dropdown
↓
Pilih Izin
↓
Local DB
↓
Supabase
↓
Widget update
```

---

# 61. FLOW E — REMINDER

```text
Create Reminder
↓
Reminder stored
↓
Widget displays reminder
↓
Approaching time
↓
System Notification
↓
User completes
↓
Reminder state updated
↓
Widget updates
```

---

# 62. EMPTY STATE

Jika tidak ada reminder:

```text
Tidak ada reminder
```

Jika belum ada attendance:

```text
Pilih status
```

Jika belum ada documentation:

tidak perlu menampilkan fake count.

Jika belum ada chat:

```text
Mulai percakapan...
```

Jika belum ada task:

```text
Belum ada task
```

---

# 63. ERROR STATE

Jika documentation gagal:

```text
Dokumentasi belum terkirim
[ Coba lagi ]
```

Jika sync gagal:

```text
Sync gagal
Data tetap tersimpan di perangkat.
```

Jika Google Drive belum connected:

```text
Google Drive belum terhubung.
```

Jangan memberikan status sukses jika operation sebenarnya gagal.

---

# 64. PERFORMANCE

Widget harus ringan.

Hindari:

* heavy API request
* large image loading
* unnecessary rebuild
* expensive animation
* full database query

Gunakan:

```text
cached state
local database
lightweight widget state
background synchronization
```

---

# 65. SECURITY

Jangan menaruh:

* access token
* service credentials
* secrets

langsung di widget.

Widget hanya berkomunikasi melalui application layer yang aman.

---

# 66. IMPLEMENTATION RULE

Sebelum coding:

1. audit project existing
2. identifikasi architecture existing
3. identifikasi state management
4. identifikasi local database
5. identifikasi Supabase integration
6. identifikasi Google Drive integration
7. identifikasi existing mobile UI
8. pertahankan component yang masih relevan
9. jangan rewrite seluruh project tanpa alasan

---

# 67. NO PLACEHOLDER IMPLEMENTATION

Jangan membuat:

```text
Future.delayed()
```

untuk pura-pura sync.

Jangan membuat:

```text
fakeDriveUrl
```

Jangan membuat:

```text
mockDocumentationUploaded = true
```

Jangan membuat:

```text
fakeReminder
```

Jika integration belum tersedia, gunakan state:

```text
Not configured
```

atau:

```text
Not connected
```

---

# 68. FINAL ACCEPTANCE CRITERIA

Implementasi dianggap selesai jika:

### Widget

* [ ] Widget utama menggunakan #BECFD8
* [ ] Radius utama 25
* [ ] Responsive terhadap ukuran widget
* [ ] Mendukung minimal small dan medium layout
* [ ] Tidak overflow
* [ ] Companion circle tersedia
* [ ] Companion dapat diganti asset-nya
* [ ] Vertical divider tersedia
* [ ] Reminder pill tersedia
* [ ] Date/day pill tersedia
* [ ] Documentation button tersedia
* [ ] Attendance dropdown tersedia
* [ ] Vertical Chat button tersedia

### Reminder

* [ ] Radius 18
* [ ] Background #6D8A9A
* [ ] White thin stroke
* [ ] Soft shadow
* [ ] Mengambil data reminder nyata
* [ ] Realtime/local update
* [ ] Terhubung dengan notification system

### Date

* [ ] Background #919FAC
* [ ] Radius 12
* [ ] Date realtime
* [ ] Day transition dapat digunakan
* [ ] Tidak mengganggu UX

### Documentation

* [ ] Background #AC3F42
* [ ] Radius 12
* [ ] Membuka camera/appropriate flow
* [ ] Photo tersimpan
* [ ] Offline support
* [ ] Google Drive upload nyata
* [ ] Supabase metadata nyata

### Attendance

* [ ] Background #6D8A9A
* [ ] Radius 12
* [ ] Masuk
* [ ] Izin
* [ ] Sakit
* [ ] Optional Libur
* [ ] Data benar-benar tersimpan

### Chat

* [ ] Vertical Chat button
* [ ] Floating Chat
* [ ] Input message
* [ ] Persistent normal messages
* [ ] Slash command autocomplete
* [ ] Ephemeral slash command UI
* [ ] Underlying data tetap persistent
* [ ] Chat history dapat dibuka kembali
* [ ] Close tidak menghapus persistent messages
* [ ] Close slash command menghapus temporary command UI
* [ ] Keyboard-aware
* [ ] Safe-area aware
* [ ] Smooth animation

### Sync

* [ ] Local-first
* [ ] Sync queue
* [ ] Retry
* [ ] Offline state
* [ ] Realtime
* [ ] Supabase metadata
* [ ] Google Drive binary storage
* [ ] No fake synchronization

---

# 69. FINAL PRODUCT PHILOSOPHY

Jejak Saku Widget harus terasa seperti:

> **sebuah benda kecil yang hidup di home screen dan membantu pengguna menjalani aktivitas PKL.**

Bukan:

> mini dashboard.

Bukan:

> launcher aplikasi.

Bukan:

> chatbot AI.

Bukan:

> widget informasi pasif.

Melainkan:

> **Interactive Field Companion.**

Pengguna dapat melihat sesuatu dengan cepat, melakukan tindakan dengan cepat, berbicara dengan Jejak Saku melalui floating chat, menyimpan aktivitas, mengambil dokumentasi, mengatur attendance, dan kembali ke aktivitasnya tanpa harus membuka aplikasi penuh setiap saat.

Core principle:

> **Widget = Quick Action**
>
> **Floating Chat = Quick Interaction**
>
> **Mobile App = Full Management**
>
> **Desktop = Command Center**

Dan yang paling penting:

> **UI yang hilang tidak berarti data yang hilang.**

Temporary UI boleh ditutup.

Persistent data harus tetap aman dan tersimpan.

