-- Trigger that automatically generates alternative medicines
-- after a new medicine is inserted into the medication table.
-- It calls the procedure generate_alternatives for the new medicine.

CREATE OR REPLACE TRIGGER trg_generate_alternatives
AFTER INSERT ON medication
FOR EACH ROW
BEGIN
    generate_alternatives(:NEW.id_medicamento);
END;
/