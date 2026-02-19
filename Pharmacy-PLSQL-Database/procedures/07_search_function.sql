CREATE OR REPLACE FUNCTION Search_Medicines (
    p_active_ingredient IN VARCHAR2,
    p_dosage            IN VARCHAR2,
    p_packaging         IN VARCHAR2
) RETURN NUMBER
IS
    v_count NUMBER;
BEGIN
    -- Clear previous results
    DELETE FROM results;

    -- Insert matching medicines
    INSERT INTO results (
        nome_dci_principio_ativo,
        nome_comercial,
        nome_dosagem,
        nome_embalagem,
        nome_titular_aim,
        preco_embalagem
    )
    SELECT
        dpa.nome_dci_principio_ativo,
        m.nome_comercial,
        d.nome_dosagem,
        e.nome_embalagem,
        ta.nome_titular_aim,
        m.preco_embalagem
    FROM medication m
    JOIN dci_principio_ativo dpa
        ON m.id_dci_principio_ativo = dpa.id_dci_principio_ativo
    JOIN dosagem d
        ON m.id_dosagem = d.id_dosagem
    JOIN embalagem e
        ON m.id_embalagem = e.id_embalagem
    JOIN titular_aim ta
        ON m.id_titular_aim = ta.id_titular_aim
    WHERE UPPER(dpa.nome_dci_principio_ativo) LIKE '%' || UPPER(TRIM(p_active_ingredient)) || '%'
      AND UPPER(d.nome_dosagem) LIKE '%' || UPPER(TRIM(p_dosage)) || '%'
      AND UPPER(e.nome_embalagem) LIKE '%' || UPPER(TRIM(p_packaging)) || '%';

    COMMIT;

    -- Check number of inserted rows
    SELECT COUNT(*) INTO v_count FROM results;

    IF v_count > 0 THEN
        RETURN 0; -- success
    ELSE
        RETURN 1; -- no results
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        RETURN 1;
END Search_Medicines;
/
