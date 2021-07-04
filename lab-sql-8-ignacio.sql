use sakila;
-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

select title, length, dense_rank() over(order by length desc) 'Rank'
from film
where length is not null and length !=0;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.
select title, length,rating, dense_rank() over(partition by rating order by length desc) 'Rank'
from film
where length is not null and length !=0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select category.name, count(film_category.film_id) as n_films
from category
join film_category on category.category_id=film_category.category_id
group by category.name;

-- 4. Which actor has appeared in the most films?
select actor.actor_id, actor.first_name, actor.last_name, count(film_actor.film_id) as n_appeareances
from actor
join film_actor
on actor.actor_id=film_actor.actor_id
group by actor.actor_id
order by count(film_actor.film_id) desc
limit 1;

-- 5. Most active customer (the customer that has rented the most number of films)
select customer.customer_id, count(rental.rental_id)
from customer
join rental
on customer.customer_id=rental.customer_id
group by customer_id
order by count(rental.rental_id) desc
limit 1;
;
-- BONUS.  Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. 
-- Give it a try. We will talk about queries with multiple join statements later in the lessons.
select film.title, count(rental.rental_id)
from film
join inventory
on film.film_id=inventory.film_id
join rental
on inventory.inventory_id=rental.inventory_id
group by film.title
order by count(rental.rental_id) desc
limit 1;
