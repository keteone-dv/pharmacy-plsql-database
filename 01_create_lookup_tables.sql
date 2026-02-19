--- create tables
CREATE TABLE forma_farmaceutica (
    id_forma_farmaceutica NUMBER PRIMARY KEY,
    nome_forma_farmaceutica VARCHAR2(100) NOT NULL
);

CREATE TABLE dci_principio_ativo (
    id_dci_principio_ativo NUMBER PRIMARY KEY,
    nome_dci_principio_ativo VARCHAR2(200) NOT NULL,
    total_medicamentos NUMBER DEFAULT 0
);

CREATE TABLE dosagem (
    id_dosagem NUMBER PRIMARY KEY,
    nome_dosagem VARCHAR2(100) NOT NULL
);

CREATE TABLE embalagem (
    id_embalagem NUMBER PRIMARY KEY,
    nome_embalagem VARCHAR2(150) NOT NULL
);

CREATE TABLE titular_aim (
    id_titular_aim NUMBER PRIMARY KEY,
    nome_titular_aim VARCHAR2(200) NOT NULL
);

CREATE TABLE grupo_homogeneo (
    id_grupo_homogeneo VARCHAR2(20) PRIMARY KEY,
    descricao_grupo_homogeneo VARCHAR2(300) NOT NULL
);
