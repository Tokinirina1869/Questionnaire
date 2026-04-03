CREATE TABLE etudiant (
    num_etudiant    VARCHAR(20) PRIMARY KEY,
    nom             VARCHAR(200) NOT NULL,
    prenoms         VARCHAR(200),
    niveau          VARCHAR(5) CHECK (niveau IN ('L1', 'L2', 'L3', 'M1', 'M2')),
    adr_email       VARCHAR(200) UNIQUE NOT NULL
);


CREATE TABLE qcm (
    num_quest           SERIAL PRIMARY KEY,
    question            TEXT NOT NULL,
    reponse1            VARCHAR(200) NOT NULL,
    reponse2            VARCHAR(200) NOT NULL,
    reponse3            VARCHAR(200) NOT NULL,
    bonne_reponse       INT CHECK (bonne_reponse IN (1,2,3,4))
);


CREATE TABLE examen (
    num_exam        SERIAL PRIMARY KEY,
    num_etudiant    VARCHAR(20) REFERENCES etudiant(num_etudiant),
    annee_univ      VARCHAR(9) NOT NULL,
    note            INTEGER CHECK (note BETWEEN 0 AND 10)
)