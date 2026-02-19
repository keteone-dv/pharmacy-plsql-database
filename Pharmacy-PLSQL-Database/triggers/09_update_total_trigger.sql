CREATE OR REPLACE TRIGGER UpdateTotal
AFTER INSERT OR UPDATE OR DELETE
ON Medication
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE DCI_Principio_Ativo
        SET total_medicamentos = NVL(total_medicamentos, 0) + 1
        WHERE id_dci_principio_ativo = :NEW.id_dci_principio_ativo;
    END IF;

    IF DELETING THEN
        UPDATE DCI_Principio_Ativo
        SET total_medicamentos = NVL(total_medicamentos, 0) - 1
        WHERE id_dci_principio_ativo = :OLD.id_dci_principio_ativo;
    END IF;

    -- Handle UPDATE of id_dci_principio_ativo
    IF UPDATING THEN
        -- Only if the active ingredient changed
        IF :OLD.id_dci_principio_ativo != :NEW.id_dci_principio_ativo THEN
            -- Decrement old
            UPDATE DCI_Principio_Ativo
            SET total_medicamentos = NVL(total_medicamentos, 0) - 1
            WHERE id_dci_principio_ativo = :OLD.id_dci_principio_ativo;

            -- Increment new
            UPDATE DCI_Principio_Ativo
            SET total_medicamentos = NVL(total_medicamentos, 0) + 1
            WHERE id_dci_principio_ativo = :NEW.id_dci_principio_ativo;
        END IF;
    END IF;
END;
/
