import 'package:flutter/material.dart';
import '../models/siswa.dart';

class PresensiProvider with ChangeNotifier {
  final List<Siswa> _siswa = [
    Siswa(nama: 'Ali'),
    Siswa(nama: 'Budi'),
    Siswa(nama: 'Citra'),
    Siswa(nama: 'Athalla'),
  ];

  List<Siswa> get siswa => _siswa;

  // Riwayat kehadiran
  final List<Map<String, dynamic>> _riwayatPresensi = [];

  List<Map<String, dynamic>> get riwayatPresensi => _riwayatPresensi;

  // Perbarui kehadiran siswa
  void updateKehadiran(int index, bool kehadiran) {
    if (index >= 0 && index < _siswa.length) {
      _siswa[index].kehadiran = kehadiran;
      notifyListeners();
    }
  }

  // Simpan kehadiran
  void simpanPresensi() {
    final jumlahHadir =
        _siswa.where((siswa) => siswa.kehadiran).length;
    final jumlahTidakHadir = _siswa.length - jumlahHadir;

    // Tambahkan ke riwayat
    _riwayatPresensi.insert(0, {
      'tanggal': DateTime.now(),
      'hadir': jumlahHadir,
      'tidakHadir': jumlahTidakHadir,
    });

    // Reset kehadiran
    for (var siswa in _siswa) {
      siswa.kehadiran = false;
    }
    notifyListeners();
  }
}
