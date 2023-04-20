--1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)SELECT reviews.player_id
SELECT DISTINCT players.*
FROM reviews
 INNER JOIN players
ON player_id=players.id

--2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
SELECT DISTINCT  videogames.id, videogames.name, videogames.release_date
FROM videogames
INNER JOIN tournament_videogame
        ON tournament_videogame.videogame_id=videogames.id
INNER JOIN tournaments
        ON tournament_videogame.tournament_id=tournaments.id
WHERE tournaments.year=2016

--3- Mostrare le categorie di ogni videogioco (1718)
SELECT videogames.id AS videogame_id, videogames.name AS videogame_name, categories.*
FROM categories
INNER JOIN category_videogame
        ON categories.id=category_videogame.category_id
      
INNER JOIN videogames
        ON category_videogame.videogame_id=videogames.id

--4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
SELECT DISTINCT software_houses.*
FROM software_houses
INNER JOIN videogames
        ON videogames.software_house_id= software_houses.id
        WHERE year(videogames.release_date)>2020

--5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55) 
SELECT DISTINCT software_houses.id AS software_house_id, 
                software_houses.name AS software_house_name,
                videogames.id AS videogame_id,
                videogames.name AS videogame_name,
                awards.id AS award_id,
                awards.name AS award_nome
FROM awards
INNER JOIN award_videogame
        ON awards.id=award_videogame.award_id

INNER JOIN videogames
        ON award_videogame.videogame_id=videogames.id

INNER JOIN software_houses
        ON videogames.software_house_id= software_houses.id
             
----6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
SELECT DISTINCT videogames.id AS vg_id,
                videogames.name AS vg_name,
                categories.id AS cat_id,
                categories.name AS cat_name, 
                pegi_labels.id AS pegi_id,
                pegi_labels.name AS pegi_name 

FROM videogames

INNER JOIN reviews
        ON reviews.videogame_id = videogames.id
INNER JOIN category_videogame
        ON category_videogame.videogame_id=videogames.id
INNER JOIN categories
        ON category_videogame.category_id=categories.id
INNER JOIN pegi_label_videogame
        ON pegi_label_videogame.videogame_id=videogames.id
INNER JOIN pegi_labels
        ON pegi_label_videogame.pegi_label_id= pegi_labels.id

WHERE reviews.rating>=4;


--7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
SELECT DISTINCT
       videogames.id AS vg_id,
       videogames.name AS vg_name

FROM tournaments
INNER JOIN tournament_videogame
        ON tournament_videogame.tournament_id= tournaments.id
        
INNER JOIN videogames
        ON tournament_videogame.videogame_id= videogames.id
                
INNER JOIN player_tournament
        ON player_tournament.tournament_id= tournaments.id

INNER JOIN players
        ON player_tournament.player_id= players.id
        WHERE players.name LIKE 's%'

--8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
SELECT tournaments.city
FROM awards
INNER JOIN award_videogame
        ON award_videogame.award_id= awards.id
INNER JOIN videogames
        ON award_videogame.videogame_id= videogames.id
INNER JOIN tournament_videogame
        ON tournament_videogame.videogame_id=videogames.id
INNER JOIN tournaments
        ON tournament_videogame.tournament_id=tournaments.id
WHERE awards.name LIKE 'Gioco dell%anno' 
  AND award_videogame.year=2018

--9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
SELECT awards.name, award_videogame.year, tournaments.year, players.*
FROM awards
INNER JOIN award_videogame
        ON award_videogame.award_id= awards.id
INNER JOIN videogames
        ON award_videogame.videogame_id= videogames.id
INNER JOIN tournament_videogame
        ON tournament_videogame.videogame_id=videogames.id
INNER JOIN tournaments
        ON tournament_videogame.tournament_id=tournaments.id
INNER JOIN player_tournament
        ON player_tournament.tournament_id=tournaments.id
INNER JOIN players
        ON player_tournament.player_id=players.id
        WHERE awards.name LIKE 'Gioco più atteso' 
          AND award_videogame.year=2018
          AND tournaments.year=2019

--*********** BONUS ***********
--10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
SELECT *
FROM software_houses
INNER JOIN videogames
        ON videogames.software_house_id=software_houses.id
        WHERE release_date= (SELECT MIN(videogames.release_date) FROM videogames)

--11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)     

--12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)
--13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 2 (10)