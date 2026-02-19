DELETE FROM alternatives;
DELETE FROM medication;
DELETE FROM forma_farmaceutica;
DELETE FROM dci_principio_ativo;
DELETE FROM dosagem;
DELETE FROM embalagem;
DELETE FROM titular_aim;
DELETE FROM grupo_homogeneo;
COMMIT;

SET SERVEROUTPUT ON;
BEGIN
    populate_pharmaceutical_forms;
    populate_active_ingredients;
    populate_dosages;
    populate_packaging;
    populate_aim_holders;
    populate_homogeneous_groups;
END;
/
--========check Search Function=========
DECLARE
    v_result NUMBER;
BEGIN
    v_result := Search_Medicines('Pantoprazol', '20 mg', 'Blister - 20 unidade(s)');
    IF v_result = 0 THEN
        DBMS_OUTPUT.PUT_LINE('✓ SUCCESS: Data inserted into RESULTS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✗ FAILED: No matching medicines');
    END IF;
END;
/
-- Show the results
SELECT * FROM results;


--====check update trigger=========== 
UPDATE DCI_Principio_Ativo
SET total_medicamentos = 0;
COMMIT;

-- insert some active ingredients

INSERT INTO DCI_Principio_Ativo (id_dci_principio_ativo, nome_dci_principio_ativo, total_medicamentos)
VALUES (101, 'Allopurinol', 0);

INSERT INTO DCI_Principio_Ativo (id_dci_principio_ativo, nome_dci_principio_ativo, total_medicamentos)
VALUES (102, 'Candesartan', 0);

COMMIT;


-- Insert a new medication--increment the total
INSERT INTO Medication (id_medicamento, id_dci_principio_ativo, nome_comercial)
VALUES (1001, 101, 'Medicine A');

-- Check result
SELECT id_dci_principio_ativo, total_medicamentos
FROM DCI_Principio_Ativo
WHERE id_dci_principio_ativo = 101;


-- Insert another medication with the same active ingredient
INSERT INTO Medication (id_medicamento, id_dci_principio_ativo, nome_comercial)
VALUES (2, 101, 'Medicine B');
COMMIT;

SELECT id_dci_principio_ativo, total_medicamentos
FROM DCI_Principio_Ativo
WHERE id_dci_principio_ativo = 101;


--Insert a medication with a different active ingredient
INSERT INTO Medication (id_medicamento, id_dci_principio_ativo, nome_comercial)
VALUES (3, 102, 'Medicine C');
COMMIT;

SELECT id_dci_principio_ativo, total_medicamentos
FROM DCI_Principio_Ativo
WHERE id_dci_principio_ativo IN (101, 102);

--  Update a medication to change its active ingredient
UPDATE Medication
SET id_dci_principio_ativo = 102
WHERE id_medicamento = 2;
COMMIT;

SELECT id_dci_principio_ativo, total_medicamentos
FROM DCI_Principio_Ativo
WHERE id_dci_principio_ativo IN (101, 102);


-- Delete a medication
DELETE FROM Medication
WHERE id_medicamento = 102;
COMMIT;

SELECT id_dci_principio_ativo, total_medicamentos
FROM DCI_Principio_Ativo
WHERE id_dci_principio_ativo IN (101, 102);


DELETE FROM Medication;
COMMIT;

--========check audit trigger==========
-- Change a price
UPDATE MEDICATION
SET PRECO_EMBALAGEM = PRECO_EMBALAGEM + 2
WHERE ROWNUM = 1;

COMMIT;

-- Delete a medicine
DELETE FROM MEDICATION
WHERE ROWNUM = 1;

COMMIT;

-- See the log
SELECT * FROM REGISTAALTERACOESPRECOS
ORDER BY DATA_ALTERACAO DESC;

--=========check alternatives=====
--Insert 3 equivalent medications (same DCI, dosage, packaging)

INSERT INTO medication (
    id_medicamento, nome_comercial,
    id_dci_principio_ativo, id_dosagem, id_embalagem,
    id_titular_aim, id_grupo_homogeneo,
    preco_embalagem, codigo_cnpem, codigo_registro
)
VALUES (1001, 'MedA', 
        101, 1, 1,
        1, 'GH0010',
        10.00, 1111, 9001);

INSERT INTO medication (
    id_medicamento, nome_comercial,
    id_dci_principio_ativo, id_dosagem, id_embalagem,
    id_titular_aim, id_grupo_homogeneo,
    preco_embalagem, codigo_cnpem, codigo_registro
)
VALUES (1002, 'MedB', 
        101, 1, 1,
        2, 'GH0010',
        12.00, 1112, 9002);

INSERT INTO medication (
    id_medicamento, nome_comercial,
    id_dci_principio_ativo, id_dosagem, id_embalagem,
    id_titular_aim, id_grupo_homogeneo,
    preco_embalagem, codigo_cnpem, codigo_registro
)
VALUES (1003, 'MedC',
        101, 1, 1,
        3, 'GH0010',
        11.50, 1113, 9003);

COMMIT;
--Insert 1 different medication (different DCI → NO ALTERNATIVES)
INSERT INTO medication (
    id_medicamento, nome_comercial,
    id_dci_principio_ativo, id_dosagem, id_embalagem,
    id_titular_aim, id_grupo_homogeneo,
    preco_embalagem, codigo_cnpem, codigo_registro
)
VALUES (1004, 'MedD',
        102, 1, 1,
        1, 'GH0186',
        14.00, 1114, 9004);

COMMIT;



SELECT * FROM alternatives ORDER BY id_medicamento, id_medicamento_alt;