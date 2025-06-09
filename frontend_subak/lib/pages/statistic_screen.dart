import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    // Data luas panen padi per bulan untuk tiga tahun
    final data2024 = [2497.81, 1568.72, 1214.3, 2038.77, 3310.43, 4491.42, 2233.86, 1329.51, 1001.96, 2784.88, 1971.93, 2462.79];
    final data2023 = [2133, 1828.8, 2865.24, 2504.05, 2414.14, 4616.63, 2523.16, 1718.33, 1249.6, 1262.4, 1921.16, 3153.85];
    final data2022 = [1717.38, 1985.69, 3167.4, 3989.82, 2871.13, 3230.25, 2233.88, 1263.34, 979.09, 1537.58, 2786.63, 3277.34];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "AgriSubak", 
          style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://img.freepik.com/free-vector/farming-agriculture-illustration_1284-16528.jpg", // Gambar latar
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Grafik Pola Tanam & Statistik Panen",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          const Text(
            "Luas Panen Padi Indonesia Selama Tahun 2022, 2023, dan 2024",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: isWideScreen ? 2.2 : 1.5,
            child: BarChart(
              BarChartData(
                barGroups: [
                  for (int i = 0; i < 12; i++) 
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: data2024[i].toDouble(), 
                          color: Colors.green, 
                          width: 12
                        ),
                        BarChartRodData(
                          toY: data2023[i].toDouble(), 
                          color: Colors.blue, 
                          width: 12
                        ),
                        BarChartRodData(
                          toY: data2022[i].toDouble(), 
                          color: Colors.orange, 
                          width: 12
                        ),
                      ],
                    ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        const bulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
                        return Text(
                          bulan[value.toInt()],
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAFDF4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.amber),
                    SizedBox(width: 8),
                    Text('Keterangan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                SizedBox(height: 10),
                Text("📊 Ringkasan Data (Statistik dalam Kartu Sederhana)", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("• Total Lahan Terdata 🌱 (misal: 120 ha)"),
                Text("• Jumlah Petani Terdaftar 👨‍🌾 (misal: 80 petani)"),
                Text("• Pola Tanam Terbaru 📅 (misal: Padi Organik)"),
                Text("• Hasil Panen Bulanan 🌾 (misal: 5.2 ton/ha)"),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // indeks statistik
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
}
