DELETE FROM Visualizzazione;
DELETE FROM Contenuto;
DELETE FROM Commento;
DELETE FROM Titolo;
DELETE FROM Utente;

INSERT INTO Utente (PasswordHash, Username, Email)
VALUES
('722bdac69950a548ba476f7e0404487eca1b8102ac2a308682268a46dd534e0d', 'mario.rossi', 'mario.rossi@email.it'), --CiaoMondo123
('723779293cab66786b03c5128cb3cc1832a90d8e614c21f198c42a2002fe3e78', 'giulia.bianchi', 'giulia.bianchi@email.it'), --Stella2024!
('86d47507fb2b27fe23d7adc34be742b6877166e3e3461c451787b93996b43c02', 'luca.verdi', 'luca.verdi@email.it'), --Passw0rd#
('dfa357c3f54987249b39a59fcbcb98bf97aad489b0f6bfd5be489ccfed966352', 'anna.neri', 'anna.neri@email.it'), --Sole&Luna22
('d7887bfb2e72b024875bdbd540ad286267e28bfb4e3920308817d19002de83f0', 'francesco.g', 'francesco.g@email.it'), --PizzaNapoli1
('7bbc2bca3b4c4f52d3c0fcceaa3bca57ac6ad088932c4183c8163acec429d753', 'chiara.r', 'chiara.r@email.it'), --Gatt0nero$
('98732ca67071f29b037949a0b4da21424e6693ea9777ddd9d9d831b698e48de9', 'matteo.b', 'matteo.b@email.it'), --1234M@tteo
('9a907a32f5d382d9392d565b570ed7b4ea1a78e522421a21984f1975bcce5c3a', 'elisa.m', 'elisa.m@email.it'), --L1bri&Fiori
('0332572ef9227b5844bb0376e51818185e4ccc079094ebdfce4a4ef30b41ccf6', 'davide.c', 'davide.c@email.it'), --Calc10Tifo#
('5cf6be08383ce46b2f78e936e97a143429ac0c650e45ae1db7de5cc02daa7a2e', 'sara.t', 'sara.t@email.it'); --Password?

INSERT INTO Titolo (Nome, Serie) 
VALUES 
('Titanic', 0),
('Avengers: EndGame', 0),
('Inception', 0),
('Mission: Impossible - Fallout', 0),
('Dune', 0),
('Blade Runner 2049', 0),
('Interstellar', 0),
('Forrest Gump', 0),
('The Shawshank Redemption', 0),
('Joker', 0),
('La La Land', 0),
('Superbad', 0),
('Get Out', 0),
('A Quiet Place', 0),
('Hereditary', 0),
('Breaking Bad', 1),
('The Sopranos', 1),
('The Crown', 1),
('Succession', 1),
('Stranger Things', 1),
('The Mandalorian', 1),
('The Witcher', 1),
('Game of Thrones', 1),
('The Office (US)', 1),
('Parks and Recreation', 1),
('Brooklyn Nine-Nine', 1),
('Ted Lasso', 1),
('Dark', 1),
('Mindhunter', 1),
('Black Mirror', 1);

INSERT INTO Contenuto (Stagione, Episodio, Titolo, Link, ID_Titolo)
VALUES
(NULL, NULL, 'Titanic', 'https://www.youtube.com/watch?v=h2YKckrS30U', 1),
(NULL, NULL, 'Avengers: Endgame', 'https://www.youtube.com/watch?v=TcMBFSGVi1c', 1),
(NULL, NULL, 'Inception', 'https://www.youtube.com/watch?v=YoHD9XEInc0', 1),
(NULL, NULL, 'Mission: Impossible - Fallout', 'https://www.youtube.com/watch?v=wb49-oV0F78', 1),
(NULL, NULL, 'Dune', 'https://www.youtube.com/watch?v=8g18jFHCLXk', 1),
(NULL, NULL, 'Blade Runner 2049', 'https://www.youtube.com/watch?v=gCcx85zbxz4', 1),
(NULL, NULL, 'Interstellar', 'https://www.youtube.com/watch?v=zSWdZVtXT7E', 1),
(NULL, NULL, 'Forrest Gump', 'https://www.youtube.com/watch?v=bLvqoHBptjg', 1),
(NULL, NULL, 'The Shawshank Redemption', 'https://www.youtube.com/watch?v=6hB3S9bIaco', 1),
(NULL, NULL, 'Joker', 'https://www.youtube.com/watch?v=zAGVQLHvwOY', 1),
(NULL, NULL, 'La La Land', 'https://www.youtube.com/watch?v=0pdqf4P9MB8', 1),
(NULL, NULL, 'Superbad', 'https://www.youtube.com/watch?v=znH6W_jvohM', 1),
(NULL, NULL, 'Get Out', 'https://www.youtube.com/watch?v=sRfnevzM9kQ', 1),
(NULL, NULL, 'A Quiet Place', 'https://www.youtube.com/watch?v=WR7cc5t7tv8', 1),
(NULL, NULL, 'Hereditary', 'https://www.youtube.com/watch?v=lkF_J6sdJ6Y', 1),
(1, 3, 'Breaking Bad', 'https://www.youtube.com/watch?v=HhesaQXLuRY', 2),
(2, 1, 'The Sopranos', 'https://www.youtube.com/watch?v=AXjH_nTc8bQ', 2),
(1, 4, 'The Crown', 'https://www.youtube.com/watch?v=4F1wQJzY6Qs', 2),
(1, 1, 'Succession', 'https://www.youtube.com/watch?v=s1vF1rZ2xgI', 2),
(3, 2, 'Stranger Things', 'https://www.youtube.com/watch?v=XWxyRGt5z9s', 2),
(4, 3, 'The Mandalorian', 'https://www.youtube.com/watch?v=aJW7dArK5FQ', 2),
(2, 1, 'The Witcher', 'https://www.youtube.com/watch?v=pt0tJwmkI9w', 2),
(1, 5, 'Game of Thrones', 'https://www.youtube.com/watch?v=K4R2wJls2k8', 2),
(2, 4, 'The Office (US)', 'https://www.youtube.com/watch?v=Diqz59jK2D8', 2),
(3, 7, 'Parks and Recreation', 'https://www.youtube.com/watch?v=H2lFbB9dECg', 2),
(2, 1, 'Brooklyn Nine-Nine', 'https://www.youtube.com/watch?v=1Ih8zJ7osQs', 2),
(5, 3, 'Ted Lasso', 'https://www.youtube.com/watch?v=3t39tR9OsFQ', 2),
(3, 4, 'Dark', 'https://www.youtube.com/watch?v=zyhfA5yxg9E', 2),
(2, 8, 'Mindhunter', 'https://www.youtube.com/watch?v=FhCSOwjp9OU', 2),
(1, 9, 'Black Mirror', 'https://www.youtube.com/watch?v=57T9cqbYax8', 2);

INSERT INTO Commento (ID_Utente, ID_Titolo, [Data], Testo, Voto)
VALUES
(1, 1, '2024-11-29', 'Un film emozionante che mi ha tenuto con il fiato sospeso. La trama è coinvolgente e i personaggi ben sviluppati.', 5),
(2, 2, '2024-11-28', 'La scena finale è stata grandiosa, ma alcuni passaggi mi sono sembrati un po’ prevedibili.', 4),
(3, 3, '2024-11-27', 'Un capolavoro assoluto. La regia e le performance sono incredibili. Lo rivedrei sicuramente!', 5),
(4, 4, '2024-11-26', 'Molto interessante, ma il ritmo un po’ lento in alcune fasi mi ha distratto.', 3),
(5, 5, '2024-11-25', 'Un’epopea visiva da vedere assolutamente sul grande schermo. Un’esperienza unica.', 5),
(6, 6, '2024-11-24', 'Un po’ troppo lungo, ma i temi trattati sono molto profondi. Merita di essere visto.', 4),
(7, 7, '2024-11-23', 'Un film molto riflessivo che lascia un segno, ma alcuni momenti erano troppo lenti.', 3),
(8, 8, '2024-11-22', 'Divertente e spensierato, ma senza nulla di troppo originale. Un buon passatempo.', 3),
(9, 9, '2024-11-21', 'Un film che tutti dovrebbero vedere. I temi trattati sono ancora attuali.', 5),
(10, 10, '2024-11-20', 'Troppo confusionario per i miei gusti. Non sono riuscito ad apprezzarlo come avrei voluto.', 2);

INSERT INTO Visualizzazione (ID_Utente, ID_Contenuto, [Data], Finito)
VALUES 
(1, 1, '2024-11-29', 1),
(1, 2, '2024-11-28', 0),
(2, 3, '2024-11-27', 1),
(3, 4, '2024-11-26', 0),
(4, 5, '2024-11-25', 1),
(5, 6, '2024-11-24', 1),
(6, 7, '2024-11-23', 0),
(7, 8, '2024-11-22', 1),
(8, 9, '2024-11-21', 0),
(9, 10, '2024-11-20', 1),
(10, 11, '2024-11-19', 1),
(1, 12, '2024-11-18', 0),
(2, 13, '2024-11-17', 1),
(3, 14, '2024-11-16', 0),
(4, 15, '2024-11-15', 1),
(5, 16, '2024-11-14', 0),
(6, 17, '2024-11-13', 1),
(7, 18, '2024-11-12', 0),
(8, 19, '2024-11-11', 1),
(9, 20, '2024-11-10', 0),
(10, 21, '2024-11-09', 1),
(1, 22, '2024-11-08', 0),
(2, 23, '2024-11-07', 1),
(3, 24, '2024-11-06', 0),
(4, 25, '2024-11-05', 1),
(5, 26, '2024-11-04', 0),
(6, 27, '2024-11-03', 1),
(7, 28, '2024-11-02', 0),
(8, 29, '2024-11-01', 1),
(9, 30, '2024-10-31', 0);




