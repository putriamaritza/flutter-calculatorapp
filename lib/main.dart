import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Kalkulator(),
    );
  }
}

class Kalkulator extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  dynamic tampilTeks = 20;

  // Widget tombol kalkulator
  Widget tombolKalkulator(String teksTombol, Color warnaTombol, Color warnaTeks) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          perhitungan(teksTombol);
        },
        child: Text(
          '$teksTombol',
          style: TextStyle(
            fontSize: 35,
            color: warnaTeks,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          backgroundColor: warnaTombol, // Warna background
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Kalkulator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Tampilan Kalkulator
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$teks',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombolKalkulator('AC', Colors.grey, Colors.black),
                tombolKalkulator('+/-', Colors.grey, Colors.black),
                tombolKalkulator('%', Colors.grey, Colors.black),
                tombolKalkulator('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombolKalkulator('7', Colors.grey[850]!, Colors.white),
                tombolKalkulator('8', Colors.grey[850]!, Colors.white),
                tombolKalkulator('9', Colors.grey[850]!, Colors.white),
                tombolKalkulator('x', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombolKalkulator('4', Colors.grey[850]!, Colors.white),
                tombolKalkulator('5', Colors.grey[850]!, Colors.white),
                tombolKalkulator('6', Colors.grey[850]!, Colors.white),
                tombolKalkulator('-', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombolKalkulator('1', Colors.grey[850]!, Colors.white),
                tombolKalkulator('2', Colors.grey[850]!, Colors.white),
                tombolKalkulator('3', Colors.grey[850]!, Colors.white),
                tombolKalkulator('+', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Tombol nol
                ElevatedButton(
                  onPressed: () {
                    perhitungan('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    backgroundColor: Colors.grey[850], // Warna background
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                tombolKalkulator('.', Colors.grey[850]!, Colors.white),
                tombolKalkulator('=', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Logika Kalkulator
  dynamic teks = '0';
  double angkaSatu = 0;
  double angkaDua = 0;

  dynamic hasil = '';
  dynamic hasilAkhir = '';
  dynamic opr = '';
  dynamic oprSebelum = '';

  void perhitungan(String teksTombol) {
    if (teksTombol == 'AC') {
      teks = '0';
      angkaSatu = 0;
      angkaDua = 0;
      hasil = '';
      hasilAkhir = '0';
      opr = '';
      oprSebelum = '';
    } else if (opr == '=' && teksTombol == '=') {
      if (oprSebelum == '+') {
        hasilAkhir = tambah();
      } else if (oprSebelum == '-') {
        hasilAkhir = kurang();
      } else if (oprSebelum == 'x') {
        hasilAkhir = kali();
      } else if (oprSebelum == '/') {
        hasilAkhir = bagi();
      }
    } else if (teksTombol == '+' || teksTombol == '-' || teksTombol == 'x' || teksTombol == '/' || teksTombol == '=') {
      if (angkaSatu == 0) {
        angkaSatu = double.parse(hasil);
      } else {
        angkaDua = double.parse(hasil);
      }

      if (opr == '+') {
        hasilAkhir = tambah();
      } else if (opr == '-') {
        hasilAkhir = kurang();
      } else if (opr == 'x') {
        hasilAkhir = kali();
      } else if (opr == '/') {
        hasilAkhir = bagi();
      }
      oprSebelum = opr;
      opr = teksTombol;
      hasil = '';
    } else if (teksTombol == '%') {
      hasil = angkaSatu / 100;
      hasilAkhir = cekDesimal(hasil);
    } else if (teksTombol == '.') {
      if (!hasil.toString().contains('.')) {
        hasil = hasil.toString() + '.';
      }
      hasilAkhir = hasil;
    } else if (teksTombol == '+/-') {
      hasil.toString().startsWith('-')
          ? hasil = hasil.toString().substring(1)
          : hasil = '-' + hasil.toString();
      hasilAkhir = hasil;
    } else {
      hasil = hasil + teksTombol;
      hasilAkhir = hasil;
    }

    setState(() {
      teks = hasilAkhir;
    });
  }

  String tambah() {
    hasil = (angkaSatu + angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String kurang() {
    hasil = (angkaSatu - angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String kali() {
    hasil = (angkaSatu * angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String bagi() {
    hasil = (angkaSatu / angkaDua).toString();
    angkaSatu = double.parse(hasil);
    return cekDesimal(hasil);
  }

  String cekDesimal(dynamic hasil) {
    if (hasil.toString().contains('.')) {
      List<String> splitDecimal = hasil.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return hasil = splitDecimal[0].toString();
      }
    }
    return hasil;
  }
}
