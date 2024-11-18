import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/presensi_provider.dart';

class PencatatanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presensiProvider = Provider.of<PresensiProvider>(context, listen: true);
    final siswa = presensiProvider.siswa;

    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final String currentDate = dateFormat.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi Siswa'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tanggal: $currentDate',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
          if (siswa.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Belum ada data siswa',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: siswa.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final dataSiswa = siswa[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[300],
                        child: Text(
                          dataSiswa.nama[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        dataSiswa.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Kehadiran: ${dataSiswa.kehadiran == true ? "Hadir" : "Tidak Hadir"}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Checkbox(
                        value: dataSiswa.kehadiran ?? false,
                        onChanged: (value) {
                          if (value != null) {
                            presensiProvider.updateKehadiran(index, value);
                          }
                        },
                        activeColor: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: siswa.isEmpty ? null : presensiProvider.simpanPresensi,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Kehadiran'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
