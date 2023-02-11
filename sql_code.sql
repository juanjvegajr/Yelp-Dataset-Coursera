/*
Data Scientist Role Play: Profiling and Analyzing the Yelp Dataset Coursera Worksheet

This is a 2-part assignment. In the first part, you are asked a series of questions that will help you profile and understand the data just like a data scientist would.

In the second part of the assignment, you are asked to come up with your own inferences and analysis of the data for a particular research question you want to answer. You will be required to prepare the dataset for the analysis you choose to do.
*/




##Part 1: Yelp Dataset Profiling and Understanding


/*
Profile the data by finding the total number of records for each of the tables below:

Attribute table
Business table
Category table
Checkin table
elite_years table
friend table
hours table
photo table
review table
tip table
user table
*/
SELECT count(business_id)
FROM attribute #10,000 rows

SELECT count(id)
FROM business #10,000

SELECT count(business_id)
FROM category #10,000

SELECT count(business_id)
FROM checkin #10,000

SELECT count(user_id)
FROM elite_years #10,000

SELECT count(user_id)
FROM friend #10,000

SELECT count(business_id)
FROM hours #10,000

SELECT count(id)
FROM photo #10,000

SELECT count(id)
FROM review #10,000

SELECT count(business_id)
FROM tip #10,000

SELECT count(id)
FROM user #10,000


##Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.
SELECT count(distinct id), count(distinct name)
FROM business #id is primary, name is foreign. 10000 and 8927 distinct counts respectively

SELECT count(distinct business_id)
FROM hours #1562 distinct values

SELECT count(distinct business_id)
FROM category #2643 distinct values

SELECT count(distinct business_id)
FROM attribute #1115 distinct values

SELECT count(distinct id), count(distinct business_id), count(distinct user_id)
FROM review #id is primary, business_id and user_id are foreign. 10000, 8090, and 9581 distinct values respectively

SELECT count(distinct business_id)
FROM checkin #493 distinct values

SELECT count(distinct id), count(distinct business_id)
FROM photo #id is primary, business_id is foreign. 10000 and 6493 distinct values respectively

SELECT count(distinct business_id), count(distinct user_id)
FROM tip #business_id is foreign, user_id is foreign. 3979 and 537 respectively

SELECT count(distinct id)
FROM user #10000 distinct values

SELECT count(distinct user_id)
FROM friend #11 distinct values

SELECT count(distinct user_id)
FROM elite_years #2780 distinct values	


##Are there any columns with null values in the Users table?
SELECT *
FROM user
WHERE
  id is null OR
  name is null OR
	review_count is null OR
	yelping_since is null OR
	useful is null OR
  funny is null OR
	cool is null OR
  fans is null OR
  average_stars is null OR
	compliment_hot is null OR
	compliment_more is null OR
	compliment_profile is null OR
	compliment_cute is null OR
  compliment_list is null OR
	compliment_note is null OR
	compliment_plain is null OR
	compliment_cool is null OR
	compliment_funny is null OR
	compliment_writer is null OR
	compliment_photos is null
#output showed no null values


/*	
For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

Review table, stars column
Business table, stars column
Tip table, likes column
Checkin table, count column
User table, review_count column
*/
SELECT
  min(stars) as min_stars,
  max(stars) as max_stars,
  avg(stars) as avg_stars
FROM review

SELECT
  min(stars) as min_stars,
  max(stars) as max_stars,
  avg(stars) as avg_stars
FROM business

SELECT
  min(likes) as min_likes,
  max(likes) as max_likes,
  avg(likes) as avg_likes
FROM tip

SELECT
  min(count) as min_count,
  max(count) as max_count,
  avg(count) as avg_count
FROM checkin

SELECT
  min(review_count) as min_review_count,
  max(review_count) as max_review_count,
  avg(review_count) as avg_review_count
FROM user


##List the cities with the most reviews in descending order:
SELECT
  city,
  sum(review_count) as review_count
FROM business
GROUP BY city
ORDER BY review_count desc

	
##Find the distribution of star ratings to the business in the following cities:
##Avon
SELECT
  stars as star_rating,
  count(stars) as count
FROM business
WHERE city = "Avon"
GROUP BY stars

##Beachwood
SELECT
  stars as star_rating,
  count(stars) as count
FROM business
WHERE city = "Beachwood"
GROUP BY stars


##Find the top 3 users based on their total number of reviews:
SELECT
  id,
  name,
  review_count
FROM user
ORDER BY review_count DESC
LIMIT 3


##Are there more reviews with the word "love" or with the word "hate" in them?
SELECT
  count(distinct text) as text_with_love,
  (SELECT
    count(distinct text)
  FROM review
  WHERE text LIKE "%hate%") as text_with_hate
FROM review
WHERE text LIKE "%love%"
##No. There are 1780 reviews with “love” and 232 reviews with “hate”
	
	
##Find the top 10 users with the most fans:
SELECT
  id,
  name,
  fans
FROM user
ORDER BY fans DESC
LIMIT 10



	

##Part 2: Inferences and Analysis
		

##Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
	
##Do the two groups you chose to analyze have a different distribution of hours?
SELECT
  b.name,
  b.stars,
  h.hours
FROM business as b
LEFT JOIN category as c
  ON b.id = c.business_id
LEFT JOIN hours as h
  ON b.id = h.business_id
WHERE b.city = "Toronto" AND c.category = "Restaurants" AND b.stars >= 2 AND h.hours LIKE "Saturday%"
GROUP BY b.name
ORDER BY b.stars ASC ##business with higher ratings are open for shorter period of times (9 hours for high rating, 13.5 hours for low rating)


##Do the two groups you chose to analyze have a different number of reviews?
SELECT
  b.name,
  count(r.id) as count
FROM business as b
LEFT JOIN category as c
  ON b.id = c.business_id
LEFT JOIN review as r
  ON b.id = r.business_id
WHERE b.city = "Toronto" AND c.category = "Restaurants" AND b.stars >= 2
GROUP BY b.name
ORDER BY b.stars ASC ##no results appears, so checked the data

SELECT *
FROM business as b
LEFT JOIN category as c
  ON b.id = c.business_id
LEFT JOIN review as r
  ON b.id = r.business_id
WHERE b.city = "Toronto" AND c.category = "Restaurants" ##no review data
         
         
##Are you able to infer anything from the location data provided between these two groups? Explain.
SELECT b.latitude, b.longitude
FROM business as b
LEFT JOIN category as c
  ON b.id = c.business_id
LEFT JOIN review as r
  ON b.id = r.business_id
WHERE b.city = "Toronto" AND c.category = "Restaurants" ##these locations are within close proximity
		
		
##Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
SELECT
  is_open,
  count(review_count) as review_count
FROM business
GROUP BY is_open ##businesses still open have over 5 times more reviews    
         
SELECT
  b.is_open,
  count(r.useful) as useful_count
FROM business as b
INNER JOIN review as r
  ON b.id = r.business_id
GROUP BY b.is_open ##businesses still open have close to 8 times more 'useful' reviews



	
/*
For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. Indicate the type of analysis you chose to do: Overall ratings per category and prediction on how successful a business will do in that category. I will also look into why certain reviews may be more impactful.
         
         
ii. Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data: I will be looking at two different tables: Category and Review. The Category table is where I’ll get most of the information for the first portion of the analysis. Here is where I’ll get overall rating information such as average stars and total review count.

From there, the Review table will give me how impactful the reviews are. For instance, how many found the reviews helpful, funny, or cool, and what kind of rating was given to a certain business. I’m hopeful that my analysis of the data will give me a better insight as to what business is successful right now and how businesses can ensure they get good reviews.

First steps will be to see top 5 categories that have the lowest rating vs top 5 categories that have the highest rating. From there, I'll look at why reviews are impactful.
*/                        
SELECT
  c.category,
  avg(r.stars) as avg_score,
  count(r.business_id) as review_count
FROM review as r
LEFT JOIN category as c
  ON r.business_id = c.business_id
GROUP BY c.category
HAVING avg_score is not null
ORDER BY avg_score ASC ##lowest rating first
LIMIT 5               

/*
Result output:
+----------------------+--------------+--------------+
| category             |    avg_score | review_count |
+----------------------+--------------+--------------+
| Arts & Entertainment |          2.0 |            1 |
| Music Venues         |          2.0 |            1 |
| None                 | 3.7347266881 |          622 |
| Active Life          |          4.0 |            1 |
| Beaches              |          4.0 |            1 |
+----------------------+--------------+--------------+
*/

SELECT
  c.category,
  avg(r.stars) as avg_score,
  count(r.business_id) as review_count
FROM review as r
LEFT JOIN category as c
  ON r.business_id = c.business_id
GROUP BY c.category
HAVING avg_score is not null
ORDER BY avg_score DESC ##highest ratings first
LIMIT 5

/*
Result output:
+------------------------+---------------+--------------+
| category               |     avg_score | review_count |
+------------------------+---------------+--------------+
| Desserts               |           5.0 |            1 |
| Sandwiches             |           5.0 |            1 |
| American (Traditional) |          4.75 |            4 |
| Barbeque               | 4.66666666667 |            3 |
| Bars                   | 4.66666666667 |            3 |
+------------------------+---------------+--------------+


Findings: Food related categories seems to have the highest ratings, while general venues seem to have lower ratings
*/

SELECT
  stars,
  avg(useful),
  avg(funny),
  avg(cool)
FROM review
WHERE useful > 0 and funny > 0 and cool > 0 ##exclude all zero counts
GROUP BY stars

/*
Result output:
+-------+---------------+---------------+---------------+
| stars |   avg(useful) |    avg(funny) |     avg(cool) |
+-------+---------------+---------------+---------------+
|     1 | 4.60283687943 | 2.43971631206 | 1.81560283688 |
|     2 |          5.05 |        3.4875 |           3.1 |
|     3 | 4.45945945946 | 2.94594594595 | 3.53513513514 |
|     4 | 4.21584699454 | 2.68852459016 | 3.41803278689 |
|     5 |  3.8820754717 | 2.55896226415 | 3.10377358491 |
+-------+---------------+---------------+---------------+

Findings: On average, more people found lower reviews more useful. Funny reviews are relatively the same across the board. The higher the rating, the more the review is found cool.


Conclusion: Businesses in food related categories have a higher chance of surviving. People find bad reviews more useful, but good reviews are found as cool. This could be further explored to see what it is exactly that users find "cool" in these reviews. From there, businesses can make changes to address those findings.
*/
