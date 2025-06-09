import 'package:flutter/material.dart';
import 'package:frontend_subak/pages/prediksi.dart';
import 'package:frontend_subak/pages/statistic_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat datang, Cahyani Dewi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              children: [
                const Text(
                  'Kelola Pertanian Lebih Mudah dengan AgriSubak 🚜',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2909/2909769.png',
                  height: 180,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Dapatkan rekomendasi pola tanam, analisis hasil panen, dan informasi subak dalam satu aplikasi.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.blue.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Cuaca 🌦️', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Lihat Detail', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pantau dan Kelola Pola Tanam dengan Mudah 🌾',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isWideScreen ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuCard(
                      context,
                      'Statistik',
                      'https://img.icons8.com/color/96/combo-chart--v1.png',
                      () {
                        // TODO: Tambahkan navigasi Statistik
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StatisticScreen()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Pola Tanam',
                      'https://img.icons8.com/color/96/vegetarian-food.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PredictScreen()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Hasil Panen',
                      'https://img.icons8.com/color/96/harvest.png',
                      () {
                        // TODO: Tambahkan navigasi Hasil Panen
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Subak',
                      'https://img.icons8.com/color/96/landscape.png',
                      () {
                        // TODO: Tambahkan navigasi Subak
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 36), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String label, String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF007E65),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 50),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
