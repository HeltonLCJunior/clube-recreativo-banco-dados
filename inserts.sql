-- =========================================
-- INSERTS - TABELA PESSOAS
-- =========================================

INSERT INTO Pessoas (Nome, Data_nascimento)
VALUES
('Helton Carvalho', '1998-05-10'),
('Maria Souza', '2000-08-15'),
('Carlos Lima', '1995-11-20'),
('Ana Oliveira', '2010-03-12'),
('Pedro Santos', '2012-07-25');

-- =========================================
-- INSERTS - TABELA PLANO_ASSINATURA
-- =========================================

INSERT INTO Plano_Assinatura (Nome_plano, Valor_plano)
VALUES
('Básico', 99.90),
('Premium', 149.90),
('Família', 199.90);

-- =========================================
-- INSERTS - TABELA SOCIO_TITULAR
-- =========================================

INSERT INTO Socio_titular (
    CPF,
    Email,
    Plano_Assinatura_idPlano,
    Pessoas_idPessoas
)
VALUES
('123.456.789-00', 'helton@email.com', 2, 1),
('987.654.321-00', 'maria@email.com', 3, 2),
('111.222.333-44', 'carlos@email.com', 1, 3);

-- =========================================
-- INSERTS - TABELA DEPENDENTE
-- =========================================

INSERT INTO Dependente (
    Parentesco,
    Socio_titular_idTitular,
    Pessoas_idPessoas
)
VALUES
('Filha', 2, 4),
('Filho', 2, 5);

-- =========================================
-- INSERTS - TABELA METODO_PAGAMENTO
-- =========================================

INSERT INTO Metodo_Pagamento (Descricao_metodo)
VALUES
('Cartão de Crédito'),
('PIX'),
('Boleto Bancário');

-- =========================================
-- INSERTS - TABELA PAGAMENTO
-- =========================================

INSERT INTO Pagamento (
    Data_pagamento,
    Valor_total,
    Status,
    Socio_titular_idTitular,
    Metodo_Pagamento_idMetodo
)
VALUES
('2026-05-01', 149.90, 'PAGO', 1, 1),
('2026-05-03', 199.90, 'PENDENTE', 2, 2),
('2026-05-05', 99.90, 'ATRASADO', 3, 3);

-- =========================================
-- INSERTS - TABELA AREA_LAZER
-- =========================================

INSERT INTO Area_lazer (Nome_area)
VALUES
('Piscina'),
('Academia'),
('Quadra de Futebol'),
('Salão de Jogos');

-- =========================================
-- INSERTS - TABELA ACESSO
-- =========================================

INSERT INTO Acesso (
    Data_Acesso,
    Hora_Acesso,
    Pessoas_idPessoas,
    Area_lazer_idArea
)
VALUES
('2026-05-10', '09:30:00', 1, 1),
('2026-05-10', '10:15:00', 2, 2),
('2026-05-10', '14:00:00', 4, 1),
('2026-05-11', '18:20:00', 3, 3),
('2026-05-11', '19:00:00', 5, 4);