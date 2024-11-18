import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/pencatatan_screen.dart';
import './screens/riwayat_screen.dart';
import './providers/presensi_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PresensiProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayarUtama(),
    );
  }
}

class LayarUtama extends StatefulWidget {
  @override
  _LayarUtamaState createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  int _indexTerpilih = 0;

  final List<Widget> _layar = [
    PencatatanScreen(),
    RiwayatLayar(),
  ];

  void _ubahLayar(int index) {
    setState(() {
      _indexTerpilih = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layar[_indexTerpilih],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Pencatatan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
        currentIndex: _indexTerpilih,
        onTap: _ubahLayar,
      ),
    );
  }
}
