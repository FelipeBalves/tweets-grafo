MATCH (t)
WHERE exists(t.source)
  AND (t:Tweet OR t:Retweet OR t:Replied_to OR t:Quoted)
RETURN t.source AS dispositivo, count(*) AS total_tweets
ORDER BY total_tweets DESC
LIMIT 1;
