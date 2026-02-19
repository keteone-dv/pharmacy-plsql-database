CREATE OR REPLACE TRIGGER AUDITAPRECOS
AFTER UPDATE OF PRECO_EMBALAGEM OR DELETE
ON MEDICATION
FOR EACH ROW
BEGIN

    -- When price is updated
    IF UPDATING THEN
        INSERT INTO REGISTAALTERACOESPRECOS (
            NOME_COMERCIAL,
            CODIGO_REGISTRO,
            PRECO_ANTIGO,
            PRECO_NOVO,
            DATA_ALTERACAO
        )
        VALUES (
            :OLD.NOME_COMERCIAL,
            :OLD.CODIGO_REGISTRO,
            :OLD.PRECO_EMBALAGEM,
            :NEW.PRECO_EMBALAGEM,
            SYSDATE
        );
    END IF;

    -- When a medicine is deleted
    IF DELETING THEN
        INSERT INTO REGISTAALTERACOESPRECOS (
            NOME_COMERCIAL,
            CODIGO_REGISTRO,
            PRECO_ANTIGO,
            PRECO_NOVO,
            DATA_ALTERACAO
        )
        VALUES (
            :OLD.NOME_COMERCIAL,
            :OLD.CODIGO_REGISTRO,
            :OLD.PRECO_EMBALAGEM,
            NULL,
            SYSDATE
        );
    END IF;

END;
/