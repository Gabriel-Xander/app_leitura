# App Leitura

Um aplicativo Flutter para gerenciar e avaliar livros lidos.

## 📱 Sobre o Projeto

App Leitura é um aplicativo simples e intuitivo que permite registrar os livros que você leu ou pretende ler, atribuir notas e acompanhar seu progresso de leitura.

## ✨ Funcionalidades

- Adicionar novos livros à sua coleção
- Marcar livros como lidos ou não lidos
- Atribuir notas de 0 a 10 aos livros
- Editar informações de livros existentes
- Remover livros da coleção
- Persistência de dados (seus livros ficam salvos mesmo após fechar o aplicativo)

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) - Framework para desenvolvimento multiplataforma
- [Dart](https://dart.dev/) - Linguagem de programação
- [Shared Preferences](https://pub.dev/packages/shared_preferences) - Para persistência de dados locais

## 📁 Estrutura do Projeto

```
lib/
├── core/
│   └── theme.dart       # Configurações de tema do aplicativo
├── models/
│   └── livro.dart       # Modelo de dados para representar um livro
├── pages/
│   └── livros_page.dart # Tela principal do aplicativo
├── widgets/
│   └── livro_card.dart  # Widget personalizado para exibir um livro
└── main.dart            # Ponto de entrada do aplicativo
```

## ⚙️ Como Executar

1. Certifique-se de ter o Flutter instalado em sua máquina
2. Clone este repositório
3. Instale as dependências:
   ```
   flutter pub get
   ```
4. Execute o aplicativo:
   ```
   flutter run
   ```

## 📝 Requisitos

- Flutter SDK versão 2.19.0 ou superior
- Dart SDK versão 2.19.0 ou superior

## 📸 Screenshots

*Adicione screenshots do seu aplicativo aqui*

## 🔮 Futuras Implementações

- Busca de livros por título
- Categorização de livros por gênero
- Sincronização com a nuvem
- Estatísticas de leitura

## 📄 Licença

Este projeto está sob a licença MIT.
