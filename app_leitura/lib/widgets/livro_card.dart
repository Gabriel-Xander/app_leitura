import 'package:flutter/material.dart';
import '../models/livro.dart';
import '../core/theme.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com status de leitura e ações
            Container(
              decoration: BoxDecoration(
                color: livro.lido ? Colors.green.withOpacity(0.1) : primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    livro.lido ? Icons.menu_book : Icons.bookmark_outline,
                    color: livro.lido ? Colors.green : primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    livro.lido ? 'Lido' : 'Não lido',
                    style: TextStyle(
                      color: livro.lido ? Colors.green : primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  _buildPopupMenu(context),
                ],
              ),
            ),
            
            // Conteúdo principal do card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    livro.titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  
                  // Avaliação com estrelas
                  Row(
                    children: [
                      const Text(
                        'Avaliação:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildRatingStars(livro.nota),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getColorForRating(livro.nota),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          livro.nota.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              const Text('Editar'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              const Text('Remover', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') onEdit();
        if (value == 'delete') onDelete();
      },
    );
  }

  Widget _buildRatingStars(double rating) {
    int fullStars = rating ~/ 2;
    bool hasHalfStar = (rating - fullStars * 2) >= 1;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          fullStars,
          (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
        ),
        if (hasHalfStar) const Icon(Icons.star_half, color: Colors.amber, size: 18),
        ...List.generate(
          emptyStars,
          (index) => const Icon(Icons.star_border, color: Colors.amber, size: 18),
        ),
      ],
    );
  }

  Color _getColorForRating(double rating) {
    if (rating >= 8) return Colors.green;
    if (rating >= 6) return Colors.blue;
    if (rating >= 4) return Colors.orange;
    return Colors.red;
  }
}
