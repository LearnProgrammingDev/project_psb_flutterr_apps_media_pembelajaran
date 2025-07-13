import 'package:flutter/material.dart';

class Bantuan extends StatelessWidget {
  const Bantuan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 60,
              right: 60,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
            ),
            child: Image.asset(
              'assets/petunjuk.png',
              height: 200,
              width: 400,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5, width: 10),
                    Text(
                      'Petunjuk Menu Pada Aplikasi',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 25.0,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.list, color: Colors.teal),
                          title: Text(
                            'Tombol Masuk Ke Halaman Materi',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 25.0,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.help, color: Colors.teal),
                          title: Text(
                            'Tombol Menuju Halaman Petunjuk',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 25.0,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.admin_panel_settings,
                            color: Colors.teal,
                          ),
                          title: Text(
                            'Tombol Menuju Halaman Profile',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                              color: Colors.teal.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
