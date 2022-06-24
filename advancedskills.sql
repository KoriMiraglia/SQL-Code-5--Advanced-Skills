/* Write a query that returns the owner_id of the owners table and the transaction_id and
service of the transactions table. Sort the results in ascending order according to 
owner_id.*/

SELECT owner_id, transaction_id, service
FROM transactions LEFT OUTER JOIN owners
ON owners.pet_id = transactions.pet_id
ORDER BY owner_id;

/*Write a query that returns the owner_id, pet_id, transaction_id, and visits_count fields from their
respective tables. Do not include records where transaction_id is NULL. Sort in order of transaction_id.*/

SELECT owners.owner_id, owners.pet_id, transaction_id, visits_count
FROM owners
LEFT OUTER JOIN transactions
ON owners.pet_id = transactions.pet_id
LEFT OUTER JOIN visits
ON transactions.pet_id = visits.pet_id
WHERE transactions.transaction_id IS NOT NULL
ORDER BY transactions.transaction_id;

/*Write a query that returns the pet_id and size from the owners table, and the visits_count
(as the alias num_visits) from the visits table. Keep only the records where dogs has 10 or more visits, and sort 
by the number of visits in descending order.*/

SELECT owners.pet_id, size, visits_count as num_visits
FROM owners LEFT JOIN visits
ON owners.pet_id = visits.pet_id
WHERE visits_count >=10
ORDER BY visits_count DESC;

/*There are 2 tables, owners and owners_2, that have information about dog owners. You want the list of all
unique dog owners from both tables. Combine these 2 tables and return a single field that shows a list of
owner_id records from both input tables, and order by owner_id. Keep only unique records.*/

SELECT owner_id FROM owners
UNION
SELECT owner_id FROM owners_2
ORDER BY owner_id;

/*You're having a customer rewards promotion and you want to identify your top three customers (owner_id)
based upon how many visits they've had. You also know that some owners have more than one pet, so you want
to add up all of their visits across all pets. Once you have this, select the top three customers (owner_id)
and list them in descending order according to number of visits (use the alias num_visits)!*/

SELECT owner_id, SUM(visits_count) AS num_visits
FROM owners AS o LEFT OUTER JOIN visits AS v
ON o.pet_id = v.pet_id
GROUP BY owner_id
ORDER BY num_visits DESC
LIMIT 3;

/*Write a query that returns owner_i from both the owners and owners_2 tables and include the transaction_id,
date, and service fields from the transactions table. Sort your results first by the date, then by transaction_id.
All rows from owners and owners_2 tables should be returned. Do not include records where transaction_id is NULL.*/

SELECT owners.owner_id, transaction_id, date, service
FROM owners LEFT OUTER JOIN transactions
ON owners.pet_id = transactions.pet_id
WHERE transaction_id IS NOT NULL
UNION ALL
SELECT owners_2.owner_id, transaction_id, date, service
FROM owners_2 LEFT OUTER JOIN transactions
ON owners_2.pet_id = transactions.pet_id
WHERE transaction_id IS NOT NULL
ORDER BY date, transaction_id;

/*Return a table that includes all records from both owners and owners_2 tables, and include a new field, 
owner_pet which is formatted as owner_id, pet_id (in other words, the owner ID followed by a comma, then a space
then the pet ID). Return only the rows where the number of visits is greater than or equal to 3 descending order.
Use the CONCAT() function for this operation instead of the te concat operator(||), as they behave differently
when working with NULL values.*/

SELECT concat(owner_id,', ', owners.pet_id) AS owner_pet, visits_count
FROM owners LEFT OUTER JOIN visits
ON owners.pet_id = visits.pet_id
WHERE visits_count >=3
UNION ALL
SELECT concat(owner_id,', ', owners_2.pet_id) AS owner_pet, visits_count
FROM owners_2 LEFT OUTER JOIN visits
ON owners_2.pet_id = visits.pet_id
WHERE visits_count >= 3
ORDER BY visits_count DESC, owner_pet;

/*Show the visit counts got each pet, and order that ouput from the most to least visits.
Include the owner_id, pet_id, and visits_count columns in your output.*/

SELECT owner_id, v.pet_id, visits_count
FROM visits AS v
INNER JOIN owners AS o
	ON v.pet_id = o.pet_id
ORDEr BY visits_count DESC;

/*Write a query that returns the owner_id, pet_id, date, and service for transactions that 
happened on June 17,2019, or fir transactions where the service provided was a haircut. 
Order your results by date.*/

SELECT owner_id, owners.pet_id, date, service
FROM transactions
LEFT OUTER JOIN owners
ON owners.pet_id = transactions.pet_id
WHERE date = '2019-06-17' OR service = 'haircut'
ORDER BY date;

/*You have a promotion where you'd like to give a gift to those pets who have had their nails done 
at the salon. Write a query that shows the pet_id and service for those pets that used the nails service
from transactions. Then sort by those pets first who are receiving a gift.*/

SELECT pet_id, service, 
	CASE 
	WHEN service = 'nails' THEN 'gift'
	ELSE 'no gift'
	END AS get_gift
FROM transactions
ORDER BY get_gift;

/*The town where the dog salon is located has a street fair on June 17 and 18. The business
owner wants to know how many transactions took place on those days.
Write a query that counts the number of transactions on 2019-06-17 and 2019-06-18 from the 
transactions table*/

SELECT date, COUNT(*)
FROM transactions
WHERE date IN ('2019-06-17', '2019-06-18')
GROUP BY date;

/*In this final challege, you want to know how many dogs there are of each size, across both lists of owners.
So, you'll want to combine the owners and owners_2 tables first, then get a count for each of the three
sizes of dogs, small, medium, and large. Then finally, sort the list from smallest to largest. Your final
outputt should show the size and count.*/

WITH all_owners AS
(SELECT * FROM owners
UNION ALL
SELECT * FROM owners_2)

SELECT size, COUNT(size) AS size_count
FROM all_owners
GROUP BY size
ORDER BY size DESC;


