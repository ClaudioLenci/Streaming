# Streaming

## Introduzione

La prova assegnata ci chiedeva di descrivere e analizzare un database per la gestione di una piattaforma streaming per poi sviluppare un'app web in ASP.NET che implementa il pattern MVC. Leggendo il testo abbiamo per prima cosa individuato quattro entità e tre relazioni a cui abbiamo assegnato i rispettivi attributi. 

### Entità 

- <b>Titolo</b>: rappresenta unicamente i film e le serie tv disponibili sulla piattaforma e contiene il <b>nome</b> del contenuto e un attributo booleano <b>serie</b> per indicare se l'oggetto da considerare è un film o una serie tv.

- <b>Utente</b>: entità per rappresentare l'utente. Ha come attributi l'<b>email</b>, lo <b>username</b>e il <b>passwordHash</b>. Quest'ultimo, per motivi di sicurezza, non memorizza direttamente la password, bensì il suo hash generato tramite l'algoritmo SHA256. 

- <b>Contenuto</b>: entità, derivata dalla risoluzione di una gerarchia, utilizzata per la rappresentazione di un singolo episodio di una serie o il contenuto proprio di un film. Gli attributi ad esso correlati sono <b>stagione</b>, <b>episodio</b> ed <b>titolo</b>(nulli nel caso di un film), e <b>link</b>, che contiene il link all'ipotetica CDN utilizzata per lo storing dei contenuti video.

### Relazioni

- <b> APPARTIENE </b> (tra <b> TITOLO </b> e <b> CONTENUTO </b>): è una relazione di tipo <b> 1 a N </b> in quanto ad ogni cortometraggio appartengono uno o più contenuti, intesi come stagioni ed episodi, mentre questi contenuti sono univoci per ogni cortometraggio. Ad esempio mentre per una serie tv ci possono essere diverse stagioni con altrettanti episodi, un film ha una sola stagione e un unico episodio.

- <b> VISUALIZZAZIONE </b> (tra <b> CONTENUTO </b> e <b> UTENTE </b>): è una relazione di tipo <b> N a N </b> in quanto un utente può visualizzare più contenuti e un contenuto può essere visualizzato da più utenti. ha come attributi la <b> data </b> di visualizzazione di tipo date e l'attributo booleano <b> finito </b> che specifica se la visualizzazione di un contenuto è terminata o meno.

- <b> COMMENTO </b> (tra <b> TITOLO </b> e <b> UTENTE </b>): è una relazione di tipo <b> N a N </b> in quanto un utente può commentare più contenuti e anche quest'ultimi possono essere commentati da più utenti, considerando però che il commento di un utente è univoco, quindi può commentare una sola volta un determinato film o una determinata serie tv. ha come attributi la <b> data </b> del commento di tipo date, il <b> voto </b> che viene dato dopo la visualizzazione e il <b> testo </b> del commento di tipo string. 

Abbiamo scelto di utilizzare l'entità <b> TITOLO </b> per gestire come un unico oggetto i film e le serie tv, quindi ognuno di questi elementi verrà indentificato con il proprio titolo e l'ID mentre per stabilire la loro natura (film o serie tv) verrà utilizzata la variabile booleana <b> serie </b>. Utilizzando questa entità abbiamo potuto gestire le eventuali informazioni riguardo questi oggetti (stagioni, episodi, link e titolo) con l'entità <b> CONTENUTO </b> 

## Schema E-R

![Schema_ER](./er_schema.svg)

## Schema Logico

- Titolo: <u>ID_Titolo (PK)</u>, Nome, Serie;

- Utente: <u>ID_Utente (PK)</u>, PasswordHash, Username, Email;

- Contenuto: <u>ID_Contenuto (PK)</u>, Stagione, Episodio, Link, Titolo, , <u>ID_Titolo (FK)</u>;
  
- Visualizzazione: Data, Finito, <u>ID_Utente (PK)</u>, <u>ID_Contenuto (FK)</u>;
  
- Commento: Data, Testo, Voto, <u>ID_Utente (FK)</u>, <u>ID_Titolo (FK)</u>;

## Tabelle in DDL

```sql
CREATE TABLE Titolo
(
    ID_Titolo INT NOT NULL PRIMARY KEY IDENTITY,
    Nome VARCHAR(100) NOT NULL,
    Serie BOOLEAN NOT NULL
)
```

```sql
CREATE TABLE Contenuto
(
    ID_Contenuto INT NOT NULL PRIMARY KEY IDENTITY,
    Stagione INT NOT NULL,
    Episodio INT NOT NULL,
    Titolo VARCHAR(100) NOT NULL,
    Link VARCHAR(100) NOT NULL,
    ID_Titolo INT NOT NULL FOREIGN KEY REFERENCES Titolo(ID_Titolo)
)
```

```sql
CREATE TABLE Utente
(
    ID_Utente INT NOT NULL PRIMARY KEY IDENTITY,
    PasswordHash VARCHAR(100) NOT NULL,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
)
```

## Query

Tutti i contenuti disponibili sulla piattaforma (film e serie TV)

```sql
SELECT Nome 
FROM Titolo
```

<b>Tutti gli utenti iscritti alla piattaforma</b>

```sql
SELECT ID_Utente, Username
FROM Utente
```

Tutti i contenuti visualizzati da un utente specifico in ordine cronologico

```sql
SELECT C.ID_Contenuto, C.Stagione, C.Episodio, C.Link, C.Titolo
FROM Contenuto C
INNER JOIN Visualizzazione V ON (C.ID_Contenuto = V.ID_Contenuto)
WHERE V.ID_Utente = <ID_Utente>
ORDER BY V.Data ASC
```

Identificare i primi tre utenti che hanno visualizzato più contenuti

```sql
SELECT TOP 3 V.ID_Utente, U.Username, COUNT(V.ID_Contenuto) AS ConteggioVisualizzazioni
FROM Visualizzazione V
INNER JOIN Utente U ON (V.ID_Utente = U.ID_Utente)
GROUP BY V.ID_Utente, U.Username
ORDER BY ConteggioVisualizzazioni DESC
```

Elencare gli utenti che hanno in sospeso la visione di contenuti e i titoli di questi contenuti

```sql
SELECT U.ID_Utente, U.Username, C.ID_Contenuto, T.Nome AS Titolo
FROM Visualizzazione V
INNER JOIN Contenuto C ON (V.ID_Contenuto = C.ID_Contenuto)
INNER JOIN Titolo T ON (C.ID_Titolo = T.ID_Titolo)
INNER JOIN Utente U ON (V.ID_Utente = U.ID_Utente)
WHERE V.Finito = 0;
```

Mostrare lo storico dei contenuti visualizzati da un utente indicando un periodo
specifico

```sql
SELECT V.Data, C.ID_Contenuto, C.Titolo, C.Stagione, C.Episodio, C.Link
FROM Visualizzazione V
INNER JOIN Contenuto C ON (V.ID_Contenuto = C.ID_Contenuto)
WHERE V.ID_Utente = <ID_Utente>
AND V.Data BETWEEN '<DataInizio>' AND '<DataFine>'
ORDER BY V.Data ASC;
```

Classifica dei contenuti più visualizzati sulla piattaforma

```sql
SELECT C.ID_Contenuto, T.Nome AS Titolo, C.Stagione, C.Episodio, COUNT(V.ID_Contenuto) AS NumeroVisualizzazioni
FROM Visualizzazione V
INNER JOIN Contenuto C ON (V.ID_Contenuto = C.ID_Contenuto)
INNER JOIN Titolo T ON (C.ID_Titolo = T.ID_Titolo)
GROUP BY C.ID_Contenuto, T.Nome, C.Stagione, C.Episodio
ORDER BY NumeroVisualizzazioni DESC;
```

Individuare i contenuti visualizzati da un utente con una durata superiore a una
certa soglia di tempo

```sql
SELECT T.nome AS Titolo, C.Stagione, C.Episodio, C.Link, C.Titolo
FROM Titolo T
INNER JOIN Contenuto C ON (T.ID_Titolo = C.ID_Titolo)
INNER JOIN Visualizzazione V ON (C.ID_Contenuto = V.ID_Contenuto)
WHERE V.Data BETWEEN '<DataInizio>' AND '<DataFine>'
```
