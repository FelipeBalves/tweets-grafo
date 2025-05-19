MATCH (t:Tweet)
WHERE NOT t:Retweet AND NOT t:Quoted AND NOT t:Replied_to
MATCH (t)-[:POSSUI]->(h:Hashtag)
WITH h, count(DISTINCT t) AS freq
ORDER BY freq DESC
LIMIT 1

MATCH (t:Tweet)-[:POSSUI]->(h)
WHERE NOT t:Retweet AND NOT t:Quoted AND NOT t:Replied_to
RETURN h, t
LIMIT 100;
