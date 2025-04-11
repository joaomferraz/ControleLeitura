import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOOKLY',
      theme: ThemeData(
        // Cores para o fundo e banners
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BOOKLY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
// Lista de Generos
  final List<String> _generos = [
    'Ficção',
    'Não Ficção',
    'Biografia',
    'Fantasia',
    'Romance',
    'Aventura',
    'Mistério',
    'Suspense',
    'História',
    'Ciência',
    'Autoajuda',
  ];

//Acoes quando haver toque
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addNewBook() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Novo livro adicionado!')),
    );
  }

  void _onGeneroSelecionado(String genero) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gênero selecionado: $genero')),
    );
  }

//Caixas para adições de futuros livros
  Widget _buildEmptyGrid(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white70,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.book_outlined,
                          size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Vazio',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final Color selectedColor = const Color(0xFF0277BD);
  final Color unselectedColor = Colors.black54;

  Widget _buildBottomItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;

// Interações com os botões da barra inferior
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? selectedColor : unselectedColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // drawer de gêneros
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildEmptyGrid('Meus Livros'),
      _buildEmptyGrid('Favoritos'),
      _buildEmptyGrid('Lidos'),
    ];

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFB3E5FC)),
              child: Text(
                'Gêneros',
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ),
            ),
            ..._generos.map((genero) => ListTile(
                  title: Text(genero),
                  onTap: () => _onGeneroSelecionado(genero),
                )),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3E5FC), // Azul claro
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      
    // botão para add livros
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBook,
        tooltip: 'Adicionar Livro',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomItem(
                index: 0,
                icon: Icons.menu_book,
                label: 'Livros',
              ),
              _buildBottomItem(
                index: 1,
                icon: Icons.favorite,
                label: 'Favoritos',
              ),
              _buildBottomItem(
                index: 2,
                icon: Icons.done,
                label: 'Lidos',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
