# IncomeApp

IncomeApp adalah aplikasi iOS berbasis SwiftUI yang berfungsi sebagai dashboard keuangan untuk mencatat **pendapatan (income)** dan **pengeluaran (expense)**. Aplikasi ini memungkinkan pengguna untuk melakukan operasi **CRUD (Create, Read, Update, Delete)** terhadap data transaksi keuangan mereka secara intuitif.

## ✨ Fitur Utama

- 📊 Dashboard keuangan dengan ringkasan total income, expense, dan saldo
- ➕ Tambah transaksi baru (income/expense)
- 📝 Edit transaksi yang sudah ada
- 🗑️ Hapus transaksi
- 🔍 Filter dan tampilkan daftar transaksi berdasarkan kategori atau tanggal
- 💾 Penyimpanan data lokal (menggunakan `CoreData` atau `UserDefaults`)
- 🌙 Tampilan mendukung Dark Mode

## 📱 Tampilan UI

- Menggunakan **SwiftUI** untuk tampilan responsif dan modern
- Navigasi sederhana berbasis tab atau navigation stack
- Tampilan input transaksi dengan validasi sederhana

## 🧱 Arsitektur

- MVVM (Model-View-ViewModel)
- Data binding dengan `@State`, `@ObservedObject`, dan `@EnvironmentObject`

## 📦 Teknologi

- **Swift** dan **SwiftUI**
- **CoreData** (opsional: bisa disesuaikan dengan `UserDefaults`)
- **Xcode** 13 atau lebih baru
- Minimum iOS: 15.0
