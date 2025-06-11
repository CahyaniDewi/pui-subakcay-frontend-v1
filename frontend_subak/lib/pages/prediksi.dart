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
    final url = Uri.parse('http://127.0.0.1:5000/predict');
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
            Text("Jenis Padi: ${input['jenis_padi']}"),
            Text("Musim: ${input['musim']} (${input['musim_bulan'].join(', ')})"),
            Text("Luas Lahan: ${input['luas_lahan']} hektar"),
            Divider(height: 24),
            Text("Cluster: ${hasil['cluster']}"),
            Text("Tingkat Kecocokan: ${hasil['ditingkat_kecocokan']}"),
            Text("Hasil: ${hasil['hasil']}"),
            Text("Musim Terbaik: ${hasil['musim_terbaik']} (${hasil['musim_bulan_terbaik'].join(', ')})"),
            Text("Saran: ${hasil['saran_musim_terbaik']}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Prediksi Produksi Padi'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("📝 Masukkan Data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Jenis Padi',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.grass),
                          ),
                          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                          onChanged: (value) => _jenisPadi = value,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Musim',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.cloud),
                          ),
                          value: _musim,
                          items: ['hujan', 'kemarau', 'peralihan']
                              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                              .toList(),
                          onChanged: (value) => setState(() => _musim = value!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Luas Lahan (hektar)',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.area_chart),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                          onChanged: (value) => _luasLahan = value,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                          icon: const Icon(Icons.analytics),
                          label: const Text('Prediksi Sekarang'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
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
      ),
    );
  }
}
