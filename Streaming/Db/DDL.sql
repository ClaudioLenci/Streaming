DROP TABLE Commento;
DROP TABLE Visualizzazione;
DROP TABLE Utente;
DROP TABLE Contenuto;
DROP TABLE Titolo;

CREATE TABLE Titolo
(
    ID_Titolo INT NOT NULL PRIMARY KEY IDENTITY,
    Nome VARCHAR(255) NOT NULL,
    Serie BIT NOT NULL
);

CREATE TABLE Contenuto
(
    ID_Contenuto INT NOT NULL PRIMARY KEY IDENTITY,
    Stagione INT,
    Episodio INT,
    Titolo VARCHAR(255),
    Link VARCHAR(1023) NOT NULL,
    ID_Titolo INT NOT NULL FOREIGN KEY REFERENCES Titolo(ID_Titolo)
);

CREATE TABLE Utente
(
    ID_Utente INT NOT NULL PRIMARY KEY IDENTITY,
    PasswordHash VARCHAR(256) NOT NULL,
    Username VARCHAR(63) NOT NULL,
    Email VARCHAR(63) NOT NULL,
);

CREATE TABLE Visualizzazione
(
	ID_Utente INT NOT NULL FOREIGN KEY REFERENCES Utente(ID_Utente),
	ID_Contenuto INT NOT NULL FOREIGN KEY REFERENCES Contenuto(ID_Contenuto),
	[Data] DATE NOT NULL,
	Finito BIT NOT NULL
);

CREATE TABLE  Commento
(
	ID_Utente INT NOT NULL FOREIGN KEY REFERENCES Utente(ID_Utente),
	ID_Titolo INT NOT NULL FOREIGN KEY REFERENCES Titolo(ID_Titolo),
	[Data] DATE NOT NULL,
	Testo VARCHAR(1023) NOT NULL,
	Voto INT NOT NULL
);