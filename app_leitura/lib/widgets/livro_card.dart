import 'package:flutter/material.dart';
import '../models/livro.dart';

class LivroCard extends StatelessWidget {
  final Livro livro;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const LivroCard({
    super.key,
    required this.livro,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          livro.lido ? Icons.check_circle : Icons.book,
          color: livro.lido ? Colors.green : Colors.grey,
        ),
        title: Text(
          livro.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Nota: ${livro.nota.toStringAsFixed(1)}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Text('Editar'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Remover'),
            ),
          ],
        ),
      ),
    );
  }
}
