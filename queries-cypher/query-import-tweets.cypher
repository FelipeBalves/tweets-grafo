CALL apoc.load.directory('*.json') YIELD value
UNWIND value AS arquivo
WITH arquivo
CALL apoc.load.json(arquivo) YIELD value
UNWIND value.data AS tweet
MERGE (t:Tweet {tweet_id: tweet.id})
ON CREATE SET t.text = tweet.text,
              t.created_at = datetime(tweet.created_at),
              t.conversation_id = tweet.conversation_id,
              t.source = tweet.source
FOREACH (ref_tweet IN tweet.referenced_tweets |
  SET t.tipo_ref = coalesce(t.tipo_ref, []) + [ref_tweet.type],
      t.id_ref = coalesce(t.id_ref, []) + [ref_tweet.id]
)
MERGE (u:User {user_id: tweet.author_id})
MERGE (u)-[:TUITOU]->(t)
WITH t, tweet.entities.hashtags AS hashtags
UNWIND hashtags AS hashtag
WITH t, apoc.text.replace(apoc.text.clean(hashtag.tag), '[^a-zA-Z0-9]', '') AS cleanedHashtag
MERGE (h:Hashtag {tag: cleanedHashtag})
MERGE (t)-[:POSSUI]->(h);