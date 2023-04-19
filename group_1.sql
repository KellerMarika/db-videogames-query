--1- Contare quante software house ci sono per ogni paese (3)
SELECT COUNT(country)AS number_softwarehouse, country
FROM software_houses 
GROUP BY country

--2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
SELECT videogame_id,
       COUNT(videogame_id)AS number_revieus
FROM reviews
GROUP BY videogame_id;

--3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
SELECT pegi_label_id AS pegi, 
       COUNT(videogame_id)AS number_videogames
FROM pegi_label_videogame
GROUP BY pegi_label_id

--4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
SELECT year(release_date) AS year, 
       COUNT(id) AS number_videogames 
FROM videogames
GROUP BY year(release_date)

--5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
SELECT device_id AS device,
COUNT(id) AS number_videogames 
FROM device_videogame
GROUP BY device_id

--6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
SELECT videogame_id
FROM reviews
GROUP BY videogame_id
ORDER BY AVG(rating)