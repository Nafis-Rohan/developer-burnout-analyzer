-- 1. Burnout by Remote Work
SELECT remotework, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE remotework IS NOT NULL
GROUP BY remotework ORDER BY avg_burnout DESC;

-- 2. Burnout by Org Size
SELECT orgsize, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE orgsize IS NOT NULL
GROUP BY orgsize ORDER BY avg_burnout DESC;

-- 3. IC vs Manager
SELECT icorpm, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE icorpm IS NOT NULL
GROUP BY icorpm ORDER BY avg_burnout DESC;

-- 4. Burnout by Salary Bracket
SELECT
    CASE
        WHEN convertedcompyearly < 30000 THEN 'Under $30K'
        WHEN convertedcompyearly < 70000 THEN '$30K–$70K'
        WHEN convertedcompyearly < 120000 THEN '$70K–$120K'
        WHEN convertedcompyearly >= 120000 THEN '$120K+'
        ELSE 'Unknown'
    END AS salary_bracket,
    ROUND(AVG(burnout_score), 2) AS avg_burnout,
    COUNT(*) AS total
FROM burnout_scores WHERE convertedcompyearly > 0
GROUP BY salary_bracket ORDER BY avg_burnout DESC;

-- 5. Top 10 Countries by Burnout (min 50 responses)
SELECT country, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE country IS NOT NULL
GROUP BY country HAVING COUNT(*) > 50
ORDER BY avg_burnout DESC LIMIT 10;

-- 6. Burnout by Industry
SELECT industry, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE industry IS NOT NULL
GROUP BY industry HAVING COUNT(*) > 30
ORDER BY avg_burnout DESC;

-- 7. Burnout by Work Experience
SELECT workexp, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores WHERE workexp IS NOT NULL
GROUP BY workexp ORDER BY workexp;
--------------------------------------------------------

-- Filter outlier work experience (likely data entry errors)
SELECT workexp, ROUND(AVG(burnout_score), 2) AS avg_burnout, COUNT(*) AS total
FROM burnout_scores
WHERE workexp IS NOT NULL AND workexp <= 50
GROUP BY workexp ORDER BY workexp;