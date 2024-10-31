WITH c AS (SELECT "topics".name, "courses".author_id
           FROM "topics"
                    INNER JOIN "expertises" ON "topics"."id" = "expertises"."topic_id"
                    INNER JOIN "courses" ON "expertises"."course_id" = "courses"."id")
SELECT c2.author_id, count(*)
from c c1,
     c c2
WHERE c1.name = c2.name
  AND c1.author_id = :author_id
  and c2.author_id <> :author_id
GROUP BY c2.author_id
ORDER BY count(*) DESC
