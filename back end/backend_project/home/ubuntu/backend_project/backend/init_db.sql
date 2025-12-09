-- Este script inicializa o banco de dados com foco apenas em credenciais de login.
-- A tabela 'cadastros' (que continha detalhes pessoais de registro) foi removida.

-- 1. Cria o Banco de Dados (Schema)
-- Se o banco de dados 'meu_sistema_db' já existir, ele será apagado e recriado.
DROP DATABASE IF EXISTS meu_sistema_db;
CREATE DATABASE meu_sistema_db;

-- Seleciona o banco de dados para trabalhar
USE meu_sistema_db;

-- 2. Tabela de Usuários (Otimizada para Login)
-- Armazena o username (usado como identificador de login) e a senha criptografada.
CREATE TABLE usuarios (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- O campo 'email' foi RENOMEADO para 'username' conforme sua solicitação.
    username VARCHAR(255) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL, -- Senha criptografada (ex: BCrypt)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- NOTA: A antiga tabela 'cadastros' foi removida, pois não é necessária para o fluxo de "apenas login".
-- Se você precisar armazenar o nome, data de nascimento ou telefone de um usuário existente,
-- é recomendável adicionar esses campos diretamente na tabela 'usuarios'.

-- 3. Tabela de Sementes (Cadastro de Estoque)
-- Mantida inalterada, pois é independente da gestão de usuários.
CREATE TABLE sementes (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_popular VARCHAR(100) NOT NULL,
    nome_cientifico VARCHAR(150),
    fabricante VARCHAR(100),
    data_validade DATE,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Criação de Índices para Performance (Opcional, mas recomendado)
-- O índice para 'cadastros' foi removido.
CREATE INDEX idx_semente_nome_popular ON sementes (nome_popular);

-- 5. Inserir usuário de teste
-- Senha: "admin123" (em texto plano para simplificar, mas em produção use BCrypt)
INSERT INTO usuarios (username, password) VALUES ('admin', 'admin123');

-- 6. Inserir algumas sementes de exemplo
INSERT INTO sementes (nome_popular, nome_cientifico, fabricante, data_validade, quantidade_estoque) VALUES
('Milho Híbrido', 'Zea mays', 'AgroSementes', '2025-12-31', 500),
('Soja Transgênica', 'Glycine max', 'BioSeeds', '2026-06-30', 300),
('Feijão Carioca', 'Phaseolus vulgaris', 'SementesBrasil', '2025-08-15', 200);
