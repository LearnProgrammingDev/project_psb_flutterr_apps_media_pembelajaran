import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data materi PDF
  final List<PdfMaterial> materials = [
    PdfMaterial(
      id: 1,
      title: 'Madilog - Materi Dasar Logika',
      subject: 'Filosofi',
      description:
          'Buku tentang materialisme, dialektika, dan logika oleh Tan Malaka',
      author: 'Tan Malaka',
      pages: 0,
      assetPath: 'assets/madilog.pdf',
      color: Colors.blue,
    ),
    PdfMaterial(
      id: 2,
      title: 'Matematika Diskrit',
      subject: 'Matematika',
      description: 'Konsep dasar matematika diskrit untuk ilmu komputer',
      author: 'Dr. Ahmad',
      pages: 0,
      assetPath: 'assets/bk-linux-dasar.pdf',
      color: Colors.green,
    ),
    PdfMaterial(
      id: 3,
      title: 'Algoritma dan Struktur Data',
      subject: 'Informatika',
      description: 'Pengantar algoritma dan struktur data fundamental',
      author: 'Prof. Budi',
      pages: 0,
      assetPath: 'assets/tan-malaka-gerpolek.pdf',
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Materi Pembelajaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: MaterialListScreen(materials: materials),
    );
  }
}

class PdfMaterial {
  final int id;
  final String title;
  final String subject;
  final String description;
  final String author;
  final int pages;
  final String assetPath;
  final Color color;

  PdfMaterial({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.author,
    required this.pages,
    required this.assetPath,
    required this.color,
  });
}

class MaterialListScreen extends StatelessWidget {
  final List<PdfMaterial> materials;

  const MaterialListScreen({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Materi untuk Dipelajari',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap pada card untuk membuka PDF viewer',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: materials.length,
              itemBuilder: (context, index) {
                final material = materials[index];
                return MaterialCard(
                  material: material,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PdfViewerScreen(material: material),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialCard extends StatelessWidget {
  final PdfMaterial material;
  final VoidCallback onTap;

  const MaterialCard({super.key, required this.material, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                material.color.withOpacity(0.1),
                material.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icon dan indicator
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: material.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: material.color.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: 40,
                        color: material.color,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: material.color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'PDF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              material.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: material.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              material.subject,
                              style: TextStyle(
                                fontSize: 12,
                                color: material.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Oleh: ${material.author}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        material.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.touch_app,
                            size: 16,
                            color: material.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Ketuk untuk membuka',
                            style: TextStyle(
                              fontSize: 12,
                              color: material.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final PdfMaterial material;

  const PdfViewerScreen({super.key, required this.material});

  @override
  PdfViewerScreenState createState() => PdfViewerScreenState();
}

class PdfViewerScreenState extends State<PdfViewerScreen> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPageCount = 0, currentPage = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.material.assetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.material.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.material.subject,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        backgroundColor: widget.material.color,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        // Control bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Total Halaman",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    "$totalPageCount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.material.color,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.material.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  onPressed: () {
                    pdfControllerPinch.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: widget.material.color,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Halaman Saat Ini",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    "$currentPage",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.material.color,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.material.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  onPressed: () {
                    pdfControllerPinch.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.material.color,
                  ),
                ),
              ),
            ],
          ),
        ),
        // PDF View
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        child:
            isLoading
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: widget.material.color),
                      const SizedBox(height: 16),
                      Text(
                        'Memuat ${widget.material.title}...',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                )
                : PdfViewPinch(
                  scrollDirection: Axis.vertical,
                  controller: pdfControllerPinch,
                  onDocumentLoaded: (doc) {
                    setState(() {
                      totalPageCount = doc.pagesCount;
                      isLoading = false;
                    });
                  },
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
      ),
    );
  }

  @override
  void dispose() {
    pdfControllerPinch.dispose();
    super.dispose();
  }
}
