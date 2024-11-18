# Streaming

## Introduzione

Leggendo il testo della prova, che ci chiedeva di descrivere e analizzare un database per la gestione di una piattaforma streaming per poi sviluppare un sito web in MVC, abbiamo individuato 4 entità e 3 relazioni a cui abbiamo integrato i rispettivi attributi. L'entità <b> TITOLO </b> riguarda i film e le serie tv disponibili sulla piattaforma e contiene il <b> nome </b> del contenuto di tipo string e un attributo booleano <b> serie </b> che può assumere i valori 0 e 1: il primo significa che l'elemento considerato è un film mentre il secondo indica che è una serie tv. La chiave primaria di <b> TITOLO </b> è <b> ID_titolo </b> e questa entità ha due relazioni, una con <b> UTENTE </b> e una con <b> CONTENUTO </b>. Per quanto riguarda quella con <b> UTENTE </b>, abbiamo realizzato la relazione <b> Commento </b> pensando che un utente può commentare più film e serie tv come anche uno di questi contenuti può essere commentato da più utenti, dunque la relazione è di tipo <b> N a N </b>. 
## Schema ER

![Schema_ER](./er_schema.svg)

## Schema Logico

- Titolo: <u>ID_Titolo (PK)</u>, Nome, Serie;

- Utente: <u>ID_Utente (PK)</u>, PasswordHash, Username, Email;

- Contenuto: <u>ID_Contenuto (PK)</u>, Stagione, Episodio, Link, Titolo, , <u>ID_Titolo (FK)</u>;
  
- Visualizzazione: Data, Finito, <u>ID_Utente (PK)</u>, <u>ID_Contenuto (FK)</u>;
  
- Commento: Data, Testo, Voto, <u>ID_Utente (FK)</u>, <u>ID_Titolo (FK)</u>;