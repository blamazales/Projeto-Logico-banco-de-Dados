# 📦 Projeto Banco de Dados E-commerce

Este repositório contém o script SQL de criação e manipulação de um banco de dados relacional voltado para uma plataforma de E-commerce. O projeto contempla clientes PF/PJ, produtos, pedidos, pagamentos, entregas, vendedores e fornecedores, permitindo análises e operações complexas sobre o negócio.

---

## 🧱 Estrutura do Banco de Dados

O banco `ecommerce` é composto pelas seguintes tabelas principais:

### 👤 `client`
- Armazena dados de clientes PF ou PJ.
- Atributos incluem: `Fname`, `Minit`, `Lname`, `CPF`, `Address`, `clientType`.

### 💳 `payments`
- Permite múltiplos métodos de pagamento por cliente.
- Tipos: `Boleto`, `Cartão`, `Dois Cartões`.

### 📦 `product`
- Contém produtos do catálogo, com categoria, avaliação e classificação infantil.

### 📦 `productStorage` e `storageLocation`
- Gerenciam a localização e quantidade dos produtos em estoque.

### 🧾 `orders`
- Representa os pedidos realizados por clientes, com status e descrição.

### 🚚 `delivery`
- Adicionada para gerenciar entregas com código de rastreio e status.

### 🧑‍💼 `seller` e `supplier`
- Vendedores e fornecedores com CPF ou CNPJ distintos.

### 🔗 Tabelas de associação
- `productSeller`: relacionamento entre produtos e vendedores.
- `storageLocation`: associação entre produtos e localizações de estoque.
