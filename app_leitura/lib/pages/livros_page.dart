import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/livro.dart';
import '../widgets/livro_card.dart';

class LivrosPage extends StatefulWidget {
  const LivrosPage({super.key});

  @override
  _LivrosPageState createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  final List<Livro> livros = [];
  final _tituloController = TextEditingController();
  double _notaSelecionada = 5.0;
  bool _lido = false;

  @override
  void initState() {
    super.initState();
    _carregarLivros();
  }

  void _adicionarLivro() {
    final titulo = _tituloController.text;
    if (titulo.isEmpty) return;

    setState(() {
      livros.add(Livro(titulo: titulo, nota: _notaSelecionada, lido: _lido));
      _tituloController.clear();
      _notaSelecionada = 5.0;
      _lido = false;
    });

    _salvarLivros();
  }

  void _removerLivro(int index) {
    setState(() {
      livros.removeAt(index);
    });
    _salvarLivros();
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              Row(
                children: [
                  const Text('Nota:'),
                  Expanded(
                    child: Slider(
                      value: notaTemp,
                      min: 0,
                      max: 10,
                      divisions: 20,
                      label: notaTemp.toStringAsFixed(1),
                      onChanged: (value) {
                        notaTemp = value;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text('Lido'),
                value: lidoTemp,
                onChanged: (value) {
                  lidoTemp = value ?? false;
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  livros[index] = Livro(
                    titulo: controller.text,
                    nota: notaTemp,
                    lido: lidoTemp,
                  );
                });
                _salvarLivros();
                Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros Lidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título do Livro'),
            ),
            Row(
              children: [
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
              ],
            ),
            CheckboxListTile(
              title: const Text('Livro lido'),
              value: _lido,
              onChanged: (value) {
                setState(() {
                  _lido = value ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: _adicionarLivro,
              child: const Text('Adicionar Livro'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: livros.isEmpty
                  ? const Center(child: Text('Nenhum livro adicionado ainda.'))
                  : ListView.builder(
                      itemCount: livros.length,
                      itemBuilder: (context, index) {
                        return LivroCard(
                          livro: livros[index],
                          onEdit: () => _editarLivro(index),
                          onDelete: () => _removerLivro(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
