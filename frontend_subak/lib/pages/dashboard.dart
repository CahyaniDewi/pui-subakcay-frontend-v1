import 'package:flutter/material.dart';
import 'package:frontend_subak/pages/prediksi.dart';
import 'package:frontend_subak/pages/statistic_screen.dart';
import 'package:provider/provider.dart';
import 'package:frontend_subak/providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selamat datang, Farmer',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              final provider = Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(!isDark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/img/ikonprofil.png'),
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
                Text(
                  'Kelola Pertanian Lebih Mudah dengan AgriSubak',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/img/ilustrasi_pertanian.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Dapatkan rekomendasi pola tanam, analisis hasil panen, dan informasi subak dalam satu aplikasi.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Pantau dan Kelola Pola Tanam dengan Mudah',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isWideScreen ? 4 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.95,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuCard(
                      context,
                      'Statistik',
                      'assets/img/statistik.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StatisticScreen()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Pola Tanam',
                      'assets/img/polatanam.png',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PredictScreen()),
                        );
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Perawatan',
                      'assets/img/perawatan.png',
                      () {
                        // TODO: Navigasi perawatan
                      },
                    ),
                    _buildMenuCard(
                      context,
                      'Subak',
                      'assets/img/subak.png',
                      () {
                        // TODO: Navigasi Subak
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
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.outline,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String label,
    String assetPath,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: 60, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

