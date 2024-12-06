
# 📱 PizzariaMob - Aplicativo Mobile para Pizzarias 🍕

**PizzariaMob** é uma aplicação mobile desenvolvida em Flutter que oferece uma interface amigável e moderna para uma pizzaria. O foco principal é criar uma experiência de usuário fluida, onde os pedidos são gerenciados através do serviço [Beeceptor](https://beeceptor.com/).  

---

## 🎯 **Objetivo**
Criar uma aplicação para gerenciar pedidos de uma pizzaria, utilizando Flutter para a interface gráfica e o Beeceptor como ferramenta para simulação de APIs e gerenciamento de pedidos.

---

## 🛠️ **Funcionalidades**
- Catálogo de pizzas com imagens e descrições.
- Adicionar itens ao carrinho.
- Simular envio de pedidos através de API utilizando o Beeceptor.
- Tela de acompanhamento do pedido.

---

## 🚀 **Tecnologias Utilizadas**
- **Flutter**: Framework para desenvolvimento multiplataforma.
- **Dart**: Linguagem de programação principal do Flutter.
- **Beeceptor**: Ferramenta para simulação de APIs.

---

## 🖥️ **Estrutura do Projeto**
```
pizzaria_mob/
├── lib/
│   ├── main.dart          # Arquivo principal do app
│   ├── screens/           # Telas do aplicativo
│   │   ├── home_screen.dart
│   │   ├── cart_screen.dart
│   │   └── order_screen.dart
│   ├── components/        # Widgets reutilizáveis
│   ├── models/            # Modelos de dados (Pizza, Pedido, etc.)
│   └── services/          # Comunicação com APIs (Beeceptor)
├── android/               # Arquivos específicos para Android
├── ios/                   # Arquivos específicos para iOS
├── pubspec.yaml           # Gerenciamento de dependências
└── README.md              # Documentação do projeto
```

---

## ⚙️ **Como Executar o Projeto**
1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/pizzaria-mob.git
   ```
2. Navegue para o diretório do projeto:
   ```bash
   cd pizzaria-mob
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo em um dispositivo ou emulador:
   ```bash
   flutter run
   ```

---

## 🔗 **Configuração do Beeceptor**
1. Acesse [Beeceptor](https://beeceptor.com/).
2. Crie um endpoint customizado (ex.: `https://minha-pizzaria.free.beeceptor.com`).
3. Configure os métodos e respostas esperadas (GET/POST).
4. Atualize o arquivo `services/api_service.dart` com o URL do seu endpoint.

---

## 📌 **Melhorias Futuras**
- Implementar autenticação de usuários.
- Integração com uma API real.
- Sistema de notificação para pedidos prontos.

---

## 🧑‍💻 **Contribuição**
Sinta-se à vontade para contribuir com o projeto! Basta abrir um _pull request_ ou reportar problemas na aba de _issues_.

---

## 📄 **Licença**
Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
