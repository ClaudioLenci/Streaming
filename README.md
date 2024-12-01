# Streaming

## Introduzione

La prova assegnata ci chiedeva di descrivere e analizzare un database per la gestione di una piattaforma streaming per poi sviluppare un'app web in ASP.NET che implementa il pattern MVC.

## Descrizione della realtà e ipotesi aggiuntive

Leggendo il testo abbiamo per prima cosa individuato quattro entità e tre relazioni a cui abbiamo assegnato i rispettivi attributi. 

### Entità 

- <b>Titolo</b>: rappresenta unicamente i film e le serie tv disponibili sulla piattaforma e contiene il <b>nome</b> del contenuto e un attributo booleano <b>serie</b> per indicare se l'oggetto da considerare è un film o una serie tv. Abbiamo scelto di utilizzare l'entità <b>Titolo</b> per gestire come un unico oggetto i film e le serie tv, dunque ognuno di questi elementi verrà indentificato tramite l'ID mentre per stabilire la loro natura (film o serie tv) verrà utilizzata la variabile booleana <b>serie</b>. Utilizzando questa entità abbiamo potuto gestire le eventuali informazioni di ognuno degli episodi dell'eventuale serie (stagione, episodio, link e titolo) con l'entità <b>Contenuto</b>.

- <b>Utente</b>: entità per rappresentare l'utente. Ha come attributi l'<b>email</b>, lo <b>username</b>e il <b>passwordHash</b>. Quest'ultimo, per motivi di sicurezza, non memorizza direttamente la password, bensì il suo hash generato tramite l'algoritmo SHA256. 

- <b>Contenuto</b>: entità, derivata dalla risoluzione di una gerarchia, utilizzata per la rappresentazione di un singolo episodio di una serie o il contenuto proprio di un film. Gli attributi ad esso correlati sono <b>stagione</b>, <b>episodio</b> ed <b>titolo</b>(nulli nel caso di un film), e <b>link</b>, che contiene il link all'ipotetica CDN utilizzata per lo storing dei contenuti video.

### Relazioni

- <b>Appartiene</b>: relazione di cardinalità <i>1 a N</i> tra le entità <b>Titolo</b> e <b>Contenuto</b>. La cardinalità risulta essere <i>1 a N</i> in quanto ad ogni titolo cinematografico appartengono uno o più contenuti (rispettivamente film o serie), intesi come stagioni ed episodi. Inoltre, ogni contenuto apparterrà ad un solo titolo.

- <b>Visualizzazione</b>: relazione tra <b>Contenuto</b> e <b>Utente</b>. La cardinalità è <i>N a N</i>, in quanto un utente può visualizzare più contenuti e un contenuto può essere visualizzato da più utenti. Ha come attributi la <b>data</b> di visualizzazione e l'attributo booleano <b>finito</b> che specifica se la visualizzazione di un contenuto è terminata o meno.

- <b>Commento</b>: relazione tra <b>Titolo</b> e <b>Utente</b>. La cardinalità è <i>N a N</i>, in quanto un utente può commentare più contenuti e anche questi ultimi possono essere commentati da più utenti. La tabella ricavata non conterrà alcuna chiave primaria in quanto si considera che il commento di un utente ad un contenuto è univoco (può commentare una sola volta un determinato film o una determinata serie tv). Ha come attributi la <b>data</b> del commento, il <b>voto</b> conferito dall'utente (tramite meccanismo delle stelle di qualità, da 1 a 5) e il <b>testo</b> del commento.

## Schema E-R

![Schema_ER](./er_schema.svg)

## Schema Logico

- Titolo: <u>ID_Titolo (PK)</u>, Nome, Serie;

- Utente: <u>ID_Utente (PK)</u>, PasswordHash, Username, Email;

- Contenuto: <u>ID_Contenuto (PK)</u>, Stagione, Episodio, Link, Titolo, , <u>ID_Titolo (FK)</u>;
  
- Visualizzazione: Data, Finito, <u>ID_Utente (PK)</u>, <u>ID_Contenuto (FK)</u>;
  
- Commento: Data, Testo, Voto, <u>ID_Utente (FK)</u>, <u>ID_Titolo (FK)</u>;

## Queries

Siccome è stato deciso di utilizzare Microsoft SQL Server come DBMS, si sono rese necessarie modifiche alle queries per la creazione del database e anche alle normali interrogazioni utilizzate nel programma. In particolare, per le queries di creazione non si è potuto utilizzare il tipo `BOOLEAN`, in quanto assente in tutte le versioni di SQL Server. Al suo posto è stato utilizzato il tipo `BIT`. Per quanto concerne, invece, le queries utilizzate nel programma, si sono dovute implementare, in alcuni casi, modifiche strutturali alla queries stesse e alla loro logica.

### Creazione del database

```sql
CREATE TABLE Titolo
(
    ID_Titolo INT NOT NULL PRIMARY KEY IDENTITY,
    Nome VARCHAR(255) NOT NULL,
    Serie BIT NOT NULL
)
```

```sql
CREATE TABLE Contenuto
(
    ID_Contenuto INT NOT NULL PRIMARY KEY IDENTITY,
    Stagione INT,
    Episodio INT,
    Titolo VARCHAR(255),
    Link VARCHAR(1023) NOT NULL,
    ID_Titolo INT NOT NULL FOREIGN KEY REFERENCES Titolo(ID_Titolo)
)
```

```sql
CREATE TABLE Utente
(
    ID_Utente INT NOT NULL PRIMARY KEY IDENTITY,
    PasswordHash VARCHAR(256) NOT NULL,
    Username VARCHAR(63) NOT NULL,
    Email VARCHAR(63) NOT NULL,
)
```

```sql
CREATE TABLE Visualizzazione
(
	ID_Utente INT NOT NULL FOREIGN KEY REFERENCES Utente(ID_Utente),
	ID_Contenuto INT NOT NULL FOREIGN KEY REFERENCES Contenuto(ID_Contenuto),
	[Data] DATE NOT NULL,
	Finito BIT NOT NULL
);
```

```sql
CREATE TABLE  Commento
(
	ID_Utente INT NOT NULL FOREIGN KEY REFERENCES Utente(ID_Utente),
	ID_Titolo INT NOT NULL FOREIGN KEY REFERENCES Titolo(ID_Titolo),
	[Data] DATE NOT NULL,
	Testo VARCHAR(1023) NOT NULL,
	Voto INT NOT NULL
);
```

### Interrogazioni del database

Tutti i contenuti disponibili sulla piattaforma (film e serie TV)

```sql
SELECT * 
FROM Titolo
```

Tutti gli utenti iscritti alla piattaforma

```sql
SELECT *
FROM Utente
```

Tutti i contenuti visualizzati da un utente specifico in ordine cronologico

```sql
SELECT Contenuto.ID_Contenuto, Stagione, Episodio, Titolo, Link
FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto
WHERE ID_Utente = 1
ORDER BY [Data]
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
SELECT Contenuto.ID_Contenuto, Stagione, Episodio, Titolo, Link
FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto
WHERE ID_Utente = 1 AND [Data] >= '2024-01-01' AND [Data] <= '2024-12-31' 
ORDER BY [Data]
```

Classifica dei contenuti più visualizzati sulla piattaforma

```sql
SELECT TOP {limit} Titolo.ID_titolo, Nome, Serie
FROM Titolo
JOIN Contenuto ON Titolo.ID_titolo = Contenuto.ID_titolo
JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto
GROUP BY ID_Titolo
ORDER BY COUNT(ID_Utente)
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

## Infrastruttura

L'ipotetica infrastruttura dell'applicazione si articolerà nei seguenti componenti:

- <b>Applicazione MVC</b>: applicazione ASP.NET con pattern MVC. Verranno servite dunque delle pagine perlopiù statiche con il contenuto già popolato sul server. I controller in cui è divisa l'applicazione sono i seguenti:
  - Controller per gli utenti
  - Controller per i titoli
  - Controller per i contenuti
- <b>Database SQL Server</b>
- <b>CDN</b>: servizio di content delivery utilizzato per la fruizione reattiva e veloce ondemand dei contenuti della piattaforma, che sarebbero altrimenti molto difficili da gestire e processare.
