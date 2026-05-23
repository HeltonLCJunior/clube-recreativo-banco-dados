-- =========================================
-- CONSULTAS SQL - CLUBE RECREATIVO
-- =========================================

-- 1. LISTAR TODOS OS SÓCIOS TITULARES
SELECT 
    s.idTitular,
    p.Nome,
    s.CPF,
    s.Email
FROM Socio_titular s
JOIN Pessoas p
ON s.Pessoas_idPessoas = p.idPessoas;

-- =========================================

-- 2. LISTAR DEPENDENTES E SEUS TITULARES
SELECT 
    pd.Nome AS Dependente,
    d.Parentesco,
    pt.Nome AS Socio_Titular
FROM Dependente d
JOIN Pessoas pd
ON d.Pessoas_idPessoas = pd.idPessoas
JOIN Socio_titular s
ON d.Socio_titular_idTitular = s.idTitular
JOIN Pessoas pt
ON s.Pessoas_idPessoas = pt.idPessoas;

-- =========================================

-- 3. LISTAR PAGAMENTOS PENDENTES
SELECT 
    p.idPagamento,
    pe.Nome,
    p.Valor_total,
    p.Status
FROM Pagamento p
JOIN Socio_titular s
ON p.Socio_titular_idTitular = s.idTitular
JOIN Pessoas pe
ON s.Pessoas_idPessoas = pe.idPessoas
WHERE p.Status = 'PENDENTE';

-- =========================================

-- 4. TOTAL DE PAGAMENTOS REALIZADOS
SELECT 
    COUNT(*) AS Total_Pagamentos
FROM Pagamento
WHERE Status = 'PAGO';

-- =========================================

-- 5. VALOR TOTAL RECEBIDO PELO CLUBE
SELECT 
    SUM(Valor_total) AS Total_Recebido
FROM Pagamento
WHERE Status = 'PAGO';

-- =========================================

-- 6. LISTAR MÉTODOS DE PAGAMENTO UTILIZADOS
SELECT 
    p.idPagamento,
    mp.Descricao_metodo,
    p.Valor_total
FROM Pagamento p
JOIN Metodo_Pagamento mp
ON p.Metodo_Pagamento_idMetodo = mp.idMetodo;

-- =========================================

-- 7. LISTAR ACESSOS ÀS ÁREAS DE LAZER
SELECT 
    pe.Nome,
    a.Data_Acesso,
    a.Hora_Acesso,
    al.Nome_area
FROM Acesso a
JOIN Pessoas pe
ON a.Pessoas_idPessoas = pe.idPessoas
JOIN Area_lazer al
ON a.Area_lazer_idArea = al.idArea;

-- =========================================

-- 8. QUANTIDADE DE ACESSOS POR ÁREA
SELECT 
    al.Nome_area,
    COUNT(*) AS Total_Acessos
FROM Acesso a
JOIN Area_lazer al
ON a.Area_lazer_idArea = al.idArea
GROUP BY al.Nome_area;

-- =========================================

-- 9. LISTAR SÓCIOS E SEUS PLANOS
SELECT 
    pe.Nome,
    pl.Nome_plano,
    pl.Valor_plano
FROM Socio_titular s
JOIN Pessoas pe
ON s.Pessoas_idPessoas = pe.idPessoas
JOIN Plano_Assinatura pl
ON s.Plano_Assinatura_idPlano = pl.idPlano;

-- =========================================

-- 10. LISTAR SÓCIOS COM PAGAMENTOS ATRASADOS
SELECT 
    pe.Nome,
    p.Valor_total,
    p.Data_pagamento
FROM Pagamento p
JOIN Socio_titular s
ON p.Socio_titular_idTitular = s.idTitular
JOIN Pessoas pe
ON s.Pessoas_idPessoas = pe.idPessoas
WHERE p.Status = 'ATRASADO';