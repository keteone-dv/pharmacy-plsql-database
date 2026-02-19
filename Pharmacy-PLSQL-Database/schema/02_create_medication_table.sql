-- Create the main medication table 
CREATE TABLE medication (
    id_medicamento NUMBER PRIMARY KEY,
    nome_comercial VARCHAR2(200) NOT NULL,
    id_forma_farmaceutica NUMBER REFERENCES forma_farmaceutica(id_forma_farmaceutica),
    id_dci_principio_ativo NUMBER REFERENCES dci_principio_ativo(id_dci_principio_ativo),
    id_dosagem NUMBER REFERENCES dosagem(id_dosagem),
    id_embalagem NUMBER REFERENCES embalagem(id_embalagem),
    id_titular_aim NUMBER REFERENCES titular_aim(id_titular_aim),
    id_grupo_homogeneo VARCHAR2(20) REFERENCES grupo_homogeneo(id_grupo_homogeneo),
    codigo_cnpem NUMBER,
    preco_embalagem NUMBER(8,2),
    codigo_registro NUMBER
);

