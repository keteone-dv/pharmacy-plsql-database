
CREATE OR REPLACE PROCEDURE generate_alternatives(p_med_id IN NUMBER)
IS
-- v_dci, v_dos, v_emb store the DCI, dosage, and packaging of the medicine
-- I am looking alternatives for. I use these values to find other
-- medicines that match the same characteristics.
    v_dci   NUMBER;
    v_dos   NUMBER;
    v_emb   NUMBER;
BEGIN
    -- Get the characteristics of the medication
    SELECT id_dci_principio_ativo, id_dosagem, id_embalagem
    INTO v_dci, v_dos, v_emb
    FROM medication
    WHERE id_medicamento = p_med_id;

    -- Insert alternatives for p_med_id
    INSERT INTO alternatives (id_medicamento, id_medicamento_alt)
    SELECT p_med_id, m.id_medicamento
    FROM medication m
    WHERE m.id_medicamento <> p_med_id
      AND m.id_dci_principio_ativo = v_dci
      AND m.id_dosagem = v_dos
      AND m.id_embalagem = v_emb
      AND NOT EXISTS (
            SELECT 1 
            FROM alternatives a
            WHERE a.id_medicamento = p_med_id
              AND a.id_medicamento_alt = m.id_medicamento
      );

    -- Insert reverse direction for symmetry
    INSERT INTO alternatives (id_medicamento, id_medicamento_alt)
    SELECT m.id_medicamento, p_med_id
    FROM medication m
    WHERE m.id_medicamento <> p_med_id
      AND m.id_dci_principio_ativo = v_dci
      AND m.id_dosagem = v_dos
      AND m.id_embalagem = v_emb
      AND NOT EXISTS (
            SELECT 1 
            FROM alternatives a
            WHERE a.id_medicamento = m.id_medicamento
              AND a.id_medicamento_alt = p_med_id
      );

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Medication not found for alternative generation: ' || p_med_id);
END;
/