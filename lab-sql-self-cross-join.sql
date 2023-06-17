USE sakila;

-- 1. Get all pairs of actors that worked together.
SELECT concat(a1.first_name," ", a1.last_name) ACTOR_1, concat(a2.first_name," ", a2.last_name) ACTOR_2, f.title Film_Title
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id
AND fa1.actor_id != fa2.actor_id
JOIN actor a1 ON a1.actor_id = fa1.actor_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id
JOIN sakila.film f ON fa1.film_id = f.film_id;

-- MY QUESTION = would I be able to create a temporary table and then self-join it? (i tried, did not work)

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT r1.customer_id ID_1, concat(c1.first_name," ", c1.last_name) Same_movie_lover_1,  r2.customer_id ID_2, concat(c2.first_name," ", c2.last_name) Same_movie_lover_2
FROM rental r1
JOIN rental r2 ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
JOIN customer c1 ON c1.customer_id = r1.customer_id
JOIN customer c2 ON c2.customer_id = r2.customer_id
GROUP BY r1.customer_id, r2.customer_id
HAVING COUNT(*) > 3;

-- 3. Get all possible pairs of actors and films.
CREATE TEMPORARY TABLE ACTORS
SELECT DISTINCT first_name, last_name
FROM sakila.actor;

CREATE TEMPORARY TABLE FILMS
SELECT DISTINCT title from film;

SELECT * FROM ACTORS
CROSS JOIN FILMS;

