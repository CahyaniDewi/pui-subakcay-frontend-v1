import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictScreen extends StatefulWidget {
  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  final _formKey = GlobalKey<FormState>();
  String _jenisPadi = '';
  String _musim = 'hujan';
  String _luasLahan = '';
  Map<String, dynamic>? _result;

  Future<void> _submit() async {
    final url = Uri.parse('http://127.0.0.1:5000/predict'); // Ganti jika perlu
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "jenis_padi": _jenisPadi,
        "musim": _musim,
        "luas_lahan": _luasLahan
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _result = json.decode(response.body);
      });
    } else {
      setState(() {
        _result = {
          "error": "Gagal mendapatkan prediksi: ${response.body}"
        };
      });
    }
  }

  Widget _buildResult() {
    if (_result == null) return SizedBox();

    if (_result!.containsKey('error')) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(_result!['error'], style: TextStyle(color: Colors.red)),
      );
    }

    final hasil = _result!['prediksi_hasil'];
    final input = _result!['input_user'];

    return Card(
      elevation: 4,
      margin: EdgeInsets.only(top: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📋 Hasil Prediksi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("✅ Jenis Padi: ${input['jenis_padi']}"),
            Text("🌦️ Musim: ${input['musim']} (${input['musim_bulan'].join(', ')})"),
            Text("🌾 Luas Lahan: ${input['luas_lahan']} hektar"),
            Divider(height: 24),
            Text("📊 Cluster: ${hasil['cluster']}"),
            Text("📈 Tingkat Kecocokan: ${hasil['ditingkat_kecocokan']}"),
            Text("🔍 Hasil: ${hasil['hasil']}"),
            Text("📅 Musim Terbaik: ${hasil['musim_terbaik']} (${hasil['musim_bulan_terbaik'].join(', ')})"),
            Text("💡 Saran: ${hasil['saran_musim_terbaik']}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediksi Produksi Padi'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("📝 Masukkan Data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Jenis Padi',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.grass),
                        ),
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                        onChanged: (value) => _jenisPadi = value,
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Musim',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.cloud),
                        ),
                        value: _musim,
                        items: ['hujan', 'kemarau', 'peralihan']
                            .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        onChanged: (value) => setState(() => _musim = value!),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Luas Lahan (hektar)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.area_chart),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                        onChanged: (value) => _luasLahan = value,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submit();
                          }
                        },
                        icon: Icon(Icons.analytics),
                        label: Text('Prediksi Sekarang'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      _buildResult()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
