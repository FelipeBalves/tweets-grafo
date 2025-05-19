MATCH (t:Tweet)
WHERE "retweeted" IN t.tipo_ref
REMOVE t:Tweet
SET t:Retweet;

MATCH (t:Tweet)
WHERE "quoted" IN t.tipo_ref
REMOVE t:Tweet
SET t:Quoted;

MATCH (t:Tweet)
WHERE "replied_to" IN t.tipo_ref
REMOVE t:Tweet
SET t:Replied_to;
