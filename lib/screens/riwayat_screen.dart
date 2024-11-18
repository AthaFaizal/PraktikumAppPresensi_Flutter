import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/presensi_provider.dart';
import 'package:intl/intl.dart';

class RiwayatLayar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final riwayatPresensi = Provider.of<PresensiProvider>(context).riwayatPresensi;

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kehadiran'),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: riwayatPresensi.isEmpty
          ? Center(
        child: Text(
          'Belum ada riwayat presensi.',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: riwayatPresensi.length,
        itemBuilder: (context, index) {
          final riwayat = riwayatPresensi[index];
          final tanggal = riwayat['tanggal'] as DateTime;

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Icon(
                Icons.calendar_today,
                color: Colors.teal,
              ),
              title: Text(
                DateFormat('dd MMM yyyy, HH:mm').format(tanggal),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Hadir: ${riwayat['hadir']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Tidak Hadir: ${riwayat['tidakHadir']}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
