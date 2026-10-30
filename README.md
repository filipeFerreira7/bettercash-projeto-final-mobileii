# 💰 BetterCash — Sistema de Gestão e Controle Financeiro com IA

[![Flutter](https://img.shields.io/badge/Flutter-3.13.4+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM%20%2B%20Factory-green)](#-arquitetura-e-padrões-de-projeto)
[![Version](https://img.shields.io/badge/API%20Contract-v1.0-blue)](#-contrato-da-api-rest-mock)

Projeto desenvolvido para a disciplina **Mobile II (Formação Mobile Dart/Flutter)**. O **BetterCash** é um sistema completo de gestão e controle de finanças pessoais com auxílio de Inteligência Artificial para análise comportamental e recomendações financeiras.

---

## 📱 Sample App & Protótipo Figma

> 🚀 **O link do Sample App / Protótipo interativo está disponível aqui:**
> 👉 **[https://narrow-portal-92823724.figma.site](https://narrow-portal-92823724.figma.site)**

### Links de Referência do Figma
- **Sample App Web / Protótipo:** [https://narrow-portal-92823724.figma.site](https://narrow-portal-92823724.figma.site)
- **UI Reference (Free Finance UI Kit):** [Figma Design Kit](https://www.figma.com/design/DHXVVUu3XT6Zr4BUN2isBd/Free-Finance-UI-Kit--Community---Copy-)
- **Design System:** [Figma Design System](https://www.figma.com/design/rUdlsvFRq93lD2hKOrfTqL/Design-System--Community---Copy-)

---

## 👨‍💻 Informações do Projeto

- **Projeto:** BetterCash — Mobile II
- **Aluno / Desenvolvedor:** Filipe Batista Ferreira
- **Arquitetura:** MVVM (Model-View-ViewModel) + Factory Pattern
- **Stack:** Flutter / Dart · API REST Mock
- **Versão do Contrato:** 1.0 (Outubro/2026)

---

## 📌 Visão Geral do Sistema

O **BetterCash** auxilia os usuários a registrarem receitas, despesas e transferências ao longo do mês. O sistema analisa o comportamento financeiro com o apoio de IA e fornece sugestões práticas para otimizar a saúde financeira.

### ⚙️ Funcionalidades Principais
- 👤 **Gerenciamento de Usuários:** Cadastro, autenticação via token JWT, e edição de perfil.
- 💳 **Gerenciamento de Transações:** CRUD completo de receitas, despesas e transferências com filtros e busca.
- 🤖 **Análise Financeira com IA:** Insights automatizados com pontuação de saúde financeira e recomendações de economia.
- 📊 **Dashboards & Gráficos:** Resumo mensal de receitas, despesas, saldo, gráficos por categoria e saldo diário.
- 📄 **Exportação de Dashboard:** Geração de relatórios com gráficos em formato PDF ou PNG.
- 📥 **Importação de Extrato Bancário:** Processamento de extratos bancários via arquivo CSV ou JSON.
- 📱 **Suporte a QR Code:** Compartilhamento rápido e preparação para pagamentos via Pix.

---

## 🏗 Arquitetura e Padrões de Projeto

O projeto adota rigorosamente o padrão **MVVM por Componente + Factory Pattern** como ponto único de criação de componentes e telas.

```
Main ──► Screens ──► Factory ──► ViewModel ◄──► Services ──► ApiClient / Mock
                       │             ▲
                       ▼             │ (notifica via ChangeNotifier)
                   Component ────────┘ (Stateless Widget puro)
```

### 🧩 Responsabilidades dos Módulos

1. **ViewModel (`*_view_model.dart`):**
   - Mantém o estado da UI e executa regras de negócio.
   - Herda de `BaseViewModel` (`ChangeNotifier`).
   - Notifica os componentes quando o estado é alterado (`notifyListeners()`).
   - Não possui acoplamento direto com código de renderização do Flutter Material.

2. **Component (`*_component.dart`):**
   - Widget puro (preferencialmente `StatelessWidget`).
   - Recebe o ViewModel e cuida apenas da renderização visual (sem lógica de negócio).

3. **Factory (`*_factory.dart`):**
   - Ponto único de criação do par `ViewModel` + `Component`.
   - Injeta os serviços e dependências necessárias. As telas invocam apenas as Factories.

4. **Common (`lib/common/`):**
   - **Theme:** Centralização dos tokens de cor, espaçamento e tipografia (`app_theme.dart`).
   - **Routes:** Gerenciamento centralizado de navegação (`app_routes.dart`).
   - **BaseViewModel:** Classe abstrata base com gerenciamento de estado (`isLoading`, `errorMessage`).
   - **Models:** Classes de domínio imutáveis que representam os dados da API.
   - **Services:** Camada de infraestrutura e acesso à API HTTP/Mock (`AuthService`, `TransactionService`, `AiService`, `DashboardService`).

---

## 📁 Estrutura de Pastas Oficial

```text
lib/
├── common/                              ← Recursos compartilhados
│   ├── theme/
│   │   └── app_theme.dart               ← Tokens: cor, espaçamento, tipografia
│   ├── routes/
│   │   └── app_routes.dart              ← Gerenciador de rotas central
│   ├── viewmodel/
│   │   └── base_view_model.dart         ← Classe base com ChangeNotifier
│   ├── models/                          ← Modelos de domínio imutáveis
│   │   ├── user.dart
│   │   ├── transaction.dart
│   │   ├── summary.dart
│   │   └── ai_insight.dart
│   └── services/                        ← Clientes HTTP e Repositórios
│       ├── api_client.dart
│       ├── auth_service.dart
│       ├── transaction_service.dart
│       ├── ai_service.dart
│       └── dashboard_service.dart
├── components/                          ← Componentes reusáveis (MVVM + Factory)
│   ├── action_button/
│   │   ├── action_button_view_model.dart
│   │   ├── action_button_component.dart
│   │   └── action_button_factory.dart
│   ├── loading/
│   ├── tab_bar/
│   ├── list_items/
│   ├── transaction_card/
│   └── chart_card/
├── screens/                             ← Telas da aplicação
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── transactions_screen.dart
│   ├── dashboard_screen.dart
│   ├── profile_screen.dart
│   └── sample_screen.dart               ← Catálogo e galeria de componentes
└── main.dart                            ← Ponto de entrada da aplicação
```

---

## 🎨 Design System (`carteira_design_system`)

O projeto inclui um pacote dedicado de Design System localizado em `design_system/`, contendo tokens fundamentais e componentes atômicos.

### 🎨 Tokens & Componentes
- **Tokens:** `AppColors`, `AppSpacing`, `AppRadius`, `AppTypography`, `AppDurations`, `AppSemanticColors`.
- **Componentes Visuais:** `AppAvatar`, `AppButton`, `AppScaffold`, `AppTextField`, `BalanceCard`, `CategoryBar`, `MoneyText`, `PasswordField`, `SectionHeader`, `StateView`, `TransactionTile`.

Para visualizar o catálogo interativo do Design System:
```bash
cd design_system/example
flutter run
```

---

## 🔌 Contrato da API REST Mock

A aplicação consome um servidor mock que segue o contrato especificado na versão 1.0.

### 🌐 Configurações da API
- **Base URL:** `http://localhost:8080` (no Emulador Android: `http://10.0.2.2:8080`)
- **Headers:** `Content-Type: application/json; charset=utf-8`
- **Autenticação:** `Authorization: Bearer <token>`
- **Latência Padrão:** 300 ms a 800 ms

### 🔑 Credenciais de Teste
| Usuário | E-mail | Senha |
|---|---|---|
| Ana Ribeiro | `ana@bettercash.dev` | `123456` |
| Bruno Souza | `bruno@bettercash.dev` | `123456` |

### 🛠 Endpoints da API

| Verbo | Rota | Autenticado? | Sucesso | Descrição |
|---|---|:---:|:---:|---|
| `GET` | `/health` | Não | `200` | Verifica se a API está online |
| `POST` | `/auth/login` | Não | `200` | Autentica o usuário e retorna o token JWT |
| `POST` | `/auth/logout` | Sim | `204` | Encerra a sessão ativa |
| `GET` | `/me` | Sim | `200` | Devolve dados do perfil do usuário logado |
| `PUT` | `/me` | Sim | `200` | Atualiza dados do perfil (`name`, `avatarUrl`) |
| `GET` | `/transactions` | Sim | `200` | Lista transações com filtros (`month`, `type`, `q`, `page`, `pageSize`) |
| `GET` | `/transactions/:id` | Sim | `200` | Retorna os detalhes de uma transação |
| `POST` | `/transactions` | Sim | `201` | Cria uma nova transação (`income`, `expense`, `transfer`) |
| `PUT` | `/transactions/:id` | Sim | `200` | Atualiza uma transação existente |
| `DELETE` | `/transactions/:id` | Sim | `204` | Remove uma transação |
| `POST` | `/transactions/import` | Sim | `200` | Importa extrato bancário via CSV ou JSON |
| `GET` | `/summary` | Sim | `200` | Retorna o resumo do mês (`income`, `expense`, `balance`) |
| `GET` | `/dashboard` | Sim | `200` | Retorna dados consolidados para gráficos e estatísticas |
| `GET` | `/dashboard/export` | Sim | `200` | Exporta o relatório do dashboard em PDF ou PNG |
| `POST` | `/ai/insights` | Sim | `200` | Gera analise preditiva e recomendações financeiras com IA |
| `GET` | `/ai/insights/:id` | Sim | `200` | Recupera um insight específico previamente gerado |
| `POST` | `/reset` | Sim | `204` | Reseta os dados da sessão aos valores padrão (seed) |

### 🧪 Cabeçalhos de Simulação (Testes e Resiliência)
- `X-Delay-Ms: 3000` — Simula latência de rede específica (em ms).
- `X-Fail: 500` — Simula erro interno do servidor (`500 Internal Server Error`).
- `X-Fail: expired` — Simula erro de token expirado (`401 Token Expired`).
- `X-Fail: timeout` — Simula timeout na requisição (`504 Gateway Timeout`).

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão `^3.13.4` ou superior)
- [Dart SDK](https://dart.dev/get-dart)
- Emulador Android / iOS ou Dispositivo Físico

### Passo a Passo

1. **Clonar o repositório:**
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd projeto_final_bettercash
   ```

2. **Instalar as dependências:**
   ```bash
   flutter pub get
   ```

3. **Executar a aplicação:**
   ```bash
   flutter run
   ```

4. **Executar os testes unitários e de widget:**
   ```bash
   flutter test
   ```

---

## ✅ Checklist de Entrega (Mobile II)

- [x] Tema extraído do Figma e centralizado em `app_theme.dart`.
- [x] Estrutura de pastas padronizada com `common`, `components` e `screens`.
- [x] `BaseViewModel` com `ChangeNotifier` implementado.
- [x] Padrão **MVVM + Factory** aplicado em todos os componentes reusáveis.
- [x] Componente `ActionButton` (primary, secondary, outline) validado contra o Figma.
- [x] Telas navegáveis: Login, Home/Dashboard, Transações e Perfil.
- [x] Integração com API REST Mock (`auth`, `transactions`, `summary`, `ai`).
- [x] Tratamento de estados da UI (Loading, Error, Empty State e Success).
- [x] Documentação em `README.md` detalhada com link do protótipo Figma.

---

<p center="true">Desenvolvido com 💙 por <b>Filipe Batista Ferreira</b> para a Formação Mobile em Dart/Flutter — 2026</p>
