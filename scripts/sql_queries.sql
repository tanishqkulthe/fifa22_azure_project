-- Query 1: Top 10 Highest Rated Players
SELECT TOP 10
    short_name,
    overall,
    nationality_name
FROM OPENROWSET(
    BULK 'https://fifa22storage.dfs.core.windows.net/transformed/fifa_players_all_years/*.parquet',
    FORMAT = 'PARQUET'
) AS fifa_data
WHERE overall >= 90
ORDER BY overall DESC

-- Query 2: Top 10 Nationalities by Player Count
SELECT TOP 10
    nationality_name,
    COUNT(*) AS player_count
FROM OPENROWSET(
    BULK 'https://fifa22storage.dfs.core.windows.net/transformed/fifa_players_all_years/*.parquet',
    FORMAT = 'PARQUET'
) AS fifa_data
GROUP BY nationality_name
ORDER BY player_count DESC

-- Query 3: Top 10 Players by Market Value
SELECT TOP 10
    short_name,
    overall,
    value_eur,
    nationality_name
FROM OPENROWSET(
    BULK 'https://fifa22storage.dfs.core.windows.net/transformed/fifa_players_all_years/*.parquet',
    FORMAT = 'PARQUET'
) AS fifa_data
WHERE value_eur IS NOT NULL AND value_eur > 0
ORDER BY value_eur DESC

-- Query 4: Top 10 Best Young Players Under 21
SELECT TOP 10
    short_name,
    age,
    overall,
    potential,
    nationality_name,
    club_name
FROM OPENROWSET(
    BULK 'https://fifa22storage.dfs.core.windows.net/transformed/fifa_players_all_years/*.parquet',
    FORMAT = 'PARQUET'
) AS fifa_data
WHERE age < 21
ORDER BY potential DESC
