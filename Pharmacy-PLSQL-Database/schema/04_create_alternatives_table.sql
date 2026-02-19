CREATE TABLE alternatives (
    id_medicamento       NUMBER REFERENCES medication(id_medicamento),
    id_medicamento_alt   NUMBER REFERENCES medication(id_medicamento),
    CONSTRAINT pk_alternatives PRIMARY KEY (id_medicamento, id_medicamento_alt)
);