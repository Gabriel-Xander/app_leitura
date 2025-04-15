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
- Filtrar livros por status (lidos/não lidos)
- Pesquisar livros por título
- Visual moderno com cards personalizados
- Avaliação com sistema de estrelas
- Persistência de dados (seus livros ficam salvos mesmo após fechar o aplicativo)

## 🛠️ Tecnologias Utilizadas

- [Flutter](https://flutter.dev/) - Framework para desenvolvimento multiplataforma
- [Dart](https://dart.dev/) - Linguagem de programação
- [Shared Preferences](https://pub.dev/packages/shared_preferences) - Para persistência de dados locais
- [Google Fonts](https://pub.dev/packages/google_fonts) - Para tipografia moderna

## 📋 Como a Listagem de Livros Funciona

O aplicativo oferece diversas maneiras de visualizar e filtrar seus livros:

### Navegação por Abas
- **Todos**: Exibe todos os livros da sua coleção
- **Lidos**: Filtra apenas os livros que você já leu
- **Não lidos**: Mostra apenas os livros que você ainda não leu

### Pesquisa
- Utilize a barra de pesquisa para encontrar livros pelo título
- A pesquisa é dinâmica e atualiza os resultados em tempo real

### Cards Informativos
Cada livro é exibido em um card contendo:
- Status de leitura (lido/não lido)
- Título do livro
- Avaliação visual com estrelas (0-5 estrelas)
- Nota numérica com código de cores (vermelho para notas baixas, verde para altas)
- Menu de opções para editar ou remover o livro

### Ordenação
Os livros são apresentados na ordem em que foram adicionados, com os mais recentes aparecendo primeiro.

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

- Categorização de livros por gênero
- Sincronização com a nuvem
- Estatísticas de leitura
- Exportação da lista de livros
- Modo escuro

## 📄 Licença

Este projeto está sob a licença MIT.
