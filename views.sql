CREATE OR REPLACE VIEW usuarios_e_localizacao AS
    SELECT u.*, l.cep, l.latitude, l.longitude
    FROM usuarios u
        LEFT JOIN localizacoes l on u.id_usuario = l.id_usuario;

CREATE OR REPLACE VIEW historicos_completos AS
    SELECT h.id_historico AS id,
        h.data_execucao AS data,
        h.descricao_resultado AS descricao,
        th.nome AS tipo_historico,
        (SELECT string_agg(p.nome, ' - ' ORDER BY p.id_produto)
        FROM historicos_produtos hp2
            JOIN produtos p ON p.id_produto = hp2.id_produto
        WHERE hp2.id_historico = h.id_historico
          AND hp2.id_usuario   = h.id_usuario) AS produto,
        u.nome AS usuario,
        e.comodo AS estante
    FROM historicos h
        JOIN estantes e ON h.id_estante = e.id_estante AND h.id_usuario = e.id_usuario
        JOIN tipos_historicos th ON h.id_tipo_historico = th.id_tipo_historico
        JOIN usuarios u ON h.id_usuario = u.id_usuario;

