CREATE DATABASE VarejoDB;
GO
USE VarejoDB;
GO

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    custo DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATETIME DEFAULT GETDATE()
);


CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    data_venda DATETIME DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);



CREATE TABLE ItensVenda (
    id_item INT PRIMARY KEY IDENTITY(1,1),
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);



CREATE TABLE Impostos (
    id_imposto INT PRIMARY KEY IDENTITY(1,1),
    id_categoria INT NOT NULL,
    aliquota DECIMAL(5,2) NOT NULL,  -- Exemplo: 18% = 18.00
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);



CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY IDENTITY(1,1),
    id_produto INT NOT NULL,
    quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel >= 0),
    ultima_atualizacao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

go

-- Inserindo Categorias
INSERT INTO Categorias (nome_categoria) VALUES ('Eletrônicos'), ('Roupas'), ('Alimentos');

-- Inserindo Produtos
INSERT INTO Produtos (nome, preco, custo, id_categoria) VALUES 
('Smartphone', 2000.00, 1500.00, 1),
('Notebook', 4500.00, 3500.00, 1),
('Camiseta', 80.00, 40.00, 2),
('Calça Jeans', 120.00, 60.00, 2),
('Chocolate', 10.00, 5.00, 3);

-- Inserindo Clientes
INSERT INTO Clientes (nome, cpf, email, telefone) VALUES 
('João Silva', '111.222.333-44', 'joao@email.com', '11999999999'),
('Maria Oliveira', '222.333.444-55', 'maria@email.com', '11888888888');

-- Inserindo Vendas
INSERT INTO Vendas (id_cliente, total) VALUES 
(1, 2080.00),  -- João comprou um smartphone e uma camiseta
(2, 4620.00);  -- Maria comprou um notebook e uma calça jeans

-- Inserindo Itens da Venda
INSERT INTO ItensVenda (id_venda, id_produto, quantidade, preco_unitario, subtotal) VALUES 
(1, 1, 1, 2000.00, 2000.00),  -- Smartphone
(1, 3, 1, 80.00, 80.00),  -- Camiseta
(2, 2, 1, 4500.00, 4500.00),  -- Notebook
(2, 4, 1, 120.00, 120.00);  -- Calça Jeans

-- Inserindo Impostos
INSERT INTO Impostos (id_categoria, aliquota) VALUES 
(1, 18.00),  -- Eletrônicos: 18%
(2, 12.00),  -- Roupas: 12%
(3, 5.00);   -- Alimentos: 5%

-- Inserindo Estoque
INSERT INTO Estoque (id_produto, quantidade_disponivel) VALUES 
(1, 50),  -- Smartphone
(2, 30),  -- Notebook
(3, 100), -- Camiseta
(4, 80),  -- Calça Jeans
(5, 200); -- Chocolate
