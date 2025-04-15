import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/livro.dart';
import '../widgets/livro_card.dart';
import '../core/theme.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  _LivrosPageState createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> with SingleTickerProviderStateMixin {
  final List<Livro> livros = [];
  final _tituloController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _notaSelecionada = 5.0;
  bool _lido = false;
  bool _isFormVisible = false;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _carregarLivros();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tituloController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
      if (!_isFormVisible) {
        _tituloController.clear();
        _notaSelecionada = 5.0;
        _lido = false;
      }
    });
  }

  void _adicionarLivro() {
    if (_formKey.currentState!.validate()) {
      final titulo = _tituloController.text.trim();
      
      setState(() {
        livros.add(Livro(titulo: titulo, nota: _notaSelecionada, lido: _lido));
        _tituloController.clear();
        _notaSelecionada = 5.0;
        _lido = false;
        _isFormVisible = false;
      });

      _salvarLivros();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Livro "$titulo" adicionado com sucesso!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _removerLivro(int index) {
    final livro = livros[index];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir "${livro.titulo}"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                livros.removeAt(index);
              });
              _salvarLivros();
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Livro "${livro.titulo}" removido.'),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void _editarLivro(int index) {
    final livro = livros[index];
    final controller = TextEditingController(text: livro.titulo);
    double notaTemp = livro.nota;
    bool lidoTemp = livro.lido;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Livro'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    prefixIcon: Icon(Icons.book),
                  ),
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            const Text('Nota:'),
                            Expanded(
                              child: Slider(
                                value: notaTemp,
                                min: 0,
                                max: 10,
                                divisions: 20,
                                label: notaTemp.toStringAsFixed(1),
                                onChanged: (value) {
                                  setState(() {
                                    notaTemp = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getColorForRating(notaTemp),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                notaTemp.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          title: const Text('Lido'),
                          value: lidoTemp,
                          secondary: Icon(
                            lidoTemp ? Icons.menu_book : Icons.bookmark_outline,
                            color: lidoTemp ? Colors.green : primaryColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              lidoTemp = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    livros[index] = Livro(
                      titulo: controller.text.trim(),
                      nota: notaTemp,
                      lido: lidoTemp,
                    );
                  });
                  _salvarLivros();
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Livro atualizado com sucesso!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _salvarLivros() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = livros.map((livro) => livro.toJson()).toList();
    await prefs.setStringList('livros', jsonList);
  }

  Future<void> _carregarLivros() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('livros') ?? [];
    setState(() {
      livros.clear();
      livros.addAll(jsonList.map((json) => Livro.fromJson(json)));
    });
  }

  List<Livro> _getLivrosFiltrados() {
    List<Livro> filteredList = livros;
    
    // Filtrar por pesquisa
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((livro) => 
        livro.titulo.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    // Filtrar por tab selecionada
    switch (_tabController.index) {
      case 1: // Lidos
        filteredList = filteredList.where((livro) => livro.lido).toList();
        break;
      case 2: // Não lidos
        filteredList = filteredList.where((livro) => !livro.lido).toList();
        break;
    }
    
    return filteredList;
  }

  Color _getColorForRating(double rating) {
    if (rating >= 8) return Colors.green;
    if (rating >= 6) return Colors.blue;
    if (rating >= 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final filteredLivros = _getLivrosFiltrados();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          onTap: (index) => setState(() {}),
          tabs: const [
            Tab(text: 'Todos'),
            Tab(text: 'Lidos'),
            Tab(text: 'Não lidos'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar livros...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          // Formulário de adição (expansível)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isFormVisible ? 260 : 0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          labelText: 'Título do Livro',
                          prefixIcon: Icon(Icons.book),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Por favor, informe o título do livro';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 8),
                          const Text('Nota:'),
                          Expanded(
                            child: Slider(
                              value: _notaSelecionada,
                              min: 0,
                              max: 10,
                              divisions: 20,
                              label: _notaSelecionada.toStringAsFixed(1),
                              onChanged: (value) {
                                setState(() {
                                  _notaSelecionada = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getColorForRating(_notaSelecionada),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _notaSelecionada.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SwitchListTile(
                        title: const Text('Livro lido'),
                        secondary: Icon(
                          _lido ? Icons.menu_book : Icons.bookmark_outline,
                          color: _lido ? Colors.green : primaryColor,
                        ),
                        value: _lido,
                        onChanged: (value) {
                          setState(() {
                            _lido = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _adicionarLivro,
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar Livro'),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Lista de livros
          Expanded(
            child: filteredLivros.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 64,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'Nenhum livro encontrado para "$_searchQuery"'
                              : 'Nenhum livro adicionado ainda.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredLivros.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      return LivroCard(
                        livro: filteredLivros[index],
                        onEdit: () => _editarLivro(livros.indexOf(filteredLivros[index])),
                        onDelete: () => _removerLivro(livros.indexOf(filteredLivros[index])),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFormVisibility,
        backgroundColor: primaryColor,
        child: Icon(_isFormVisible ? Icons.close : Icons.add),
      ),
    );
  }
}
