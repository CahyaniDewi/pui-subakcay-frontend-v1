import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    final data2024 = [2497.81, 1568.72, 1214.3, 2038.77, 3310.43, 4491.42, 2233.86, 1329.51, 1001.96, 2784.88, 1971.93, 2462.79];
    final data2023 = [2133.0, 1828.8, 2865.24, 2504.05, 2414.14, 4616.63, 2523.16, 1718.33, 1249.6, 1262.4, 1921.16, 3153.85];
    final data2022 = [1717.38, 1985.69, 3167.4, 3989.82, 2871.13, 3230.25, 2233.88, 1263.34, 979.09, 1537.58, 2786.63, 3277.34];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('AgriSubak', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 99, 209, 224), Color(0xFFf5fff7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 24),
          children: [
            const Text(
              "Statistik Luas Panen Padi\nTahun 2022 - 2024",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 137, 3)),
            ),
            const SizedBox(height: 8),
            const Text(
              "Perbandingan luas panen padi bulanan selama tiga tahun terakhir di Indonesia",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: isWideScreen ? 2.2 : 1.4,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(12, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(toY: data2024[i], color: Colors.green, width: 6),
                        BarChartRodData(toY: data2023[i], color: Colors.blue, width: 6),
                        BarChartRodData(toY: data2022[i], color: Colors.orange, width: 6),
                      ],
                      barsSpace: 4,
                    );
                  }),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const bulan = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              bulan[value.toInt()],
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true, drawHorizontalLine: true),
                  barTouchData: BarTouchData(enabled: true),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "📊 Penjelasan Diagram:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Grafik ini menunjukkan perbandingan luas panen padi tiap bulan pada tahun 2022, 2023, dan 2024. "
              "Setiap batang menunjukkan hasil panen dalam satuan hektar (ha). "
              "Dari grafik, terlihat tren perubahan pola panen per tahun, serta bulan-bulan dengan panen tertinggi atau terendah.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendItem(color: Colors.green, label: '2024'),
                SizedBox(width: 12),
                LegendItem(color: Colors.blue, label: '2023'),
                SizedBox(width: 12),
                LegendItem(color: Colors.orange, label: '2022'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
