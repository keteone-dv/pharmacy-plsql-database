
-- procedures

CREATE OR REPLACE PROCEDURE populate_pharmaceutical_forms
IS
    v_form_name LISTAGEMMEDICAMENTOS.FORMA_FARMACEUTICA%TYPE;
    v_counter NUMBER := 0;
    CURSOR c_forms IS
        SELECT DISTINCT FORMA_FARMACEUTICA
        FROM LISTAGEMMEDICAMENTOS
        WHERE FORMA_FARMACEUTICA IS NOT NULL;
BEGIN
    FOR form_rec IN c_forms LOOP
        v_counter := v_counter + 1;
        
        INSERT INTO forma_farmaceutica (
            id_forma_farmaceutica, 
            nome_forma_farmaceutica
        ) VALUES (
            v_counter, 
            form_rec.FORMA_FARMACEUTICA
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' pharmaceutical forms');
END populate_pharmaceutical_forms;
/

CREATE OR REPLACE PROCEDURE populate_active_ingredients
IS
    v_dci_name LISTAGEMMEDICAMENTOS.DCI%TYPE;
    v_counter NUMBER := 0;
    CURSOR c_dcis IS
        SELECT DISTINCT DCI
        FROM LISTAGEMMEDICAMENTOS
        WHERE DCI IS NOT NULL;
BEGIN
    FOR dci_rec IN c_dcis LOOP
        v_counter := v_counter + 1;
        
        INSERT INTO dci_principio_ativo (
            id_dci_principio_ativo, 
            nome_dci_principio_ativo
        ) VALUES (
            v_counter, 
            dci_rec.DCI
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' active ingredients');
END populate_active_ingredients;
/

CREATE OR REPLACE PROCEDURE populate_dosages
IS
    v_counter NUMBER := 0;
    CURSOR c_dosages IS
        SELECT DISTINCT DOSAGEM
        FROM LISTAGEMMEDICAMENTOS
        WHERE DOSAGEM IS NOT NULL  -- Already have this
        AND TRIM(DOSAGEM) IS NOT NULL  -- Also check for empty strings
        AND DOSAGEM != ' ';  -- Check for spaces
BEGIN
    FOR dosage_rec IN c_dosages LOOP
        -- Additional safety check
        IF dosage_rec.DOSAGEM IS NOT NULL AND LENGTH(TRIM(dosage_rec.DOSAGEM)) > 0 THEN
            v_counter := v_counter + 1;
            
            INSERT INTO dosagem (
                id_dosagem, 
                nome_dosagem
            ) VALUES (
                v_counter, 
                TRIM(dosage_rec.DOSAGEM)  -- Trim whitespace
            );
        END IF;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' dosages');
END populate_dosages;
/

CREATE OR REPLACE PROCEDURE populate_packaging
IS
    v_packaging_info LISTAGEMMEDICAMENTOS.EMBALAGEM_N_UNIDADES_VOLUME%TYPE;
    v_counter NUMBER := 0;
    CURSOR c_packaging IS
        SELECT DISTINCT EMBALAGEM_N_UNIDADES_VOLUME
        FROM LISTAGEMMEDICAMENTOS
        WHERE EMBALAGEM_N_UNIDADES_VOLUME IS NOT NULL;
BEGIN
    FOR packaging_rec IN c_packaging LOOP
        v_counter := v_counter + 1;
        
        INSERT INTO embalagem (
            id_embalagem, 
            nome_embalagem
        ) VALUES (
            v_counter, 
            packaging_rec.EMBALAGEM_N_UNIDADES_VOLUME
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' packaging types');
END populate_packaging;
/
CREATE OR REPLACE PROCEDURE populate_aim_holders
IS
    v_holder_name LISTAGEMMEDICAMENTOS.TITULAR_AIM%TYPE;
    v_counter NUMBER := 0;
    CURSOR c_holders IS
        SELECT DISTINCT TITULAR_AIM
        FROM LISTAGEMMEDICAMENTOS
        WHERE TITULAR_AIM IS NOT NULL;
BEGIN
    FOR holder_rec IN c_holders LOOP
        v_counter := v_counter + 1;
        
        INSERT INTO titular_aim (
            id_titular_aim, 
            nome_titular_aim
        ) VALUES (
            v_counter, 
            holder_rec.TITULAR_AIM
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' AIM holders');
END populate_aim_holders;
/

CREATE OR REPLACE PROCEDURE populate_homogeneous_groups
IS
    v_group_id LISTAGEMMEDICAMENTOS.GRUPO_HOMOGENEO%TYPE;
    v_group_desc LISTAGEMMEDICAMENTOS.GRUPO%TYPE;
    v_counter NUMBER := 0;
    CURSOR c_groups IS
        SELECT DISTINCT GRUPO_HOMOGENEO, GRUPO
        FROM LISTAGEMMEDICAMENTOS
        WHERE GRUPO_HOMOGENEO IS NOT NULL AND GRUPO IS NOT NULL;
BEGIN
    FOR group_rec IN c_groups LOOP
        v_counter := v_counter + 1;
        
        INSERT INTO grupo_homogeneo (
            id_grupo_homogeneo, 
            descricao_grupo_homogeneo
        ) VALUES (
            group_rec.GRUPO_HOMOGENEO, 
            group_rec.GRUPO
        );
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inserted ' || v_counter || ' homogeneous groups'); 
END populate_homogeneous_groups;
/
