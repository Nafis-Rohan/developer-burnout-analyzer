CREATE OR REPLACE VIEW burnout_scores AS
SELECT *,
    (
        (10 - jobsat::numeric)
        + (LENGTH(aifrustration) - LENGTH(REPLACE(aifrustration, ';', '')) + 1) *
          CASE WHEN aifrustration = 'Not Specified' THEN 0 ELSE 1 END
        + CASE WHEN aithreat = 'Yes' THEN 2
               WHEN aithreat = 'I''m not sure' THEN 1
               ELSE 0 END
        + CASE WHEN aisent = 'Very unfavorable' THEN 3
               WHEN aisent = 'Unfavorable' THEN 2
               WHEN aisent = 'Indifferent' THEN 1
               ELSE 0 END
        + CASE WHEN aicomplex = 'Very poor at handling complex tasks' THEN 3
               WHEN aicomplex = 'Bad at handling complex tasks' THEN 2
               WHEN aicomplex = 'Neither good or bad at handling complex tasks' THEN 1
               ELSE 0 END
    ) AS burnout_score,
    CASE
        WHEN convertedcompyearly < 30000 THEN 'Under $30K'
        WHEN convertedcompyearly < 70000 THEN '$30K–$70K'
        WHEN convertedcompyearly < 120000 THEN '$70K–$120K'
        WHEN convertedcompyearly >= 120000 THEN '$120K+'
        ELSE 'Unknown'
    END AS salary_bracket
FROM burnout_data
WHERE jobsat IS NOT NULL;

SELECT * FROM burnout_scores LIMIT 100;