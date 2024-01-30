# PokeApp
PokeApp adalah aplikasi wikipedia terkait dengan pokemon dengan data-data yang di provide melalui API : https://pokeapi.co/

## Setup Development
Version:
- iOS: 13.0 - Minimum Version
- XCode: 15.2 
- Swift: 5.0

Langkah _run_ proyek:
1. Masuk ke direktori PokeApp melalui terminal.
2. Lakukan perintah pod install.
3. Buka file **PokeApp.xcworkspace** di dalam direktorinya dan Build (command + B).
4. Pilih target **scheme** sesuai environment yang akan digunakan.
5. Untuk _run_ proyek aplikasi, pilih perangkat yang digunakan dan Run (command + R).

## Feature
1. Pokemon List Page : Page menampilkan list pokemon (limit 10 per page).
2. Pokemon Detail Page: Page menampilkan data pokemon lebih terperinci (moves and types), user dapat melakukan catch pokemon dengan menekan tombol yang berada di ujung kanan atas dengan probability 50%, user juga dapat menambahkan nickname terhadap pokemon yang berhasil ditangkapnya.
3. Pokemon List Page: Page menampilkan list pokemon yang sudah di tangkap, user dapat melakukan rename dengan melakukan swipe kanan (terdapat fitur fibonaci pada saat merubah nama), user dapat melakukan swipe kiri untuk release pokemon (terdapat fungsi random angka 1...100 dan pengecekan nomor prima atau tidak).
