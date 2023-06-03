-- Percentage cases in the entire population
SELECT location, SUM(total_cases) AS Total_cases, population, ((population))/SUM(total_cases) *100 AS Population_percentage
FROM death
WHERE continent is NOT NULL
GROUP BY location, population
HAVING SUM(total_cases) IS NOT NULL
ORDER BY Population_percentage

---
SELECT	CONVERT(date,d.date) AS date, d.continent, d.location, d.population, 
		COALESCE(v.new_vaccinations,0) AS new_vaccinations,
		SUM(CAST(v.new_vaccinations as bigint)) OVER (PARTITION BY d.location ORDER BY d.location, d.date)
FROM death d JOIN vaccine v 
ON d.date = v.date AND d.location = v.location
WHERE d.continent is NOT NULL
ORDER BY d.location, d.date

-- ALT
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
		SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date)
FROM death dea JOIN vaccine vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- WORKED

SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
		SUM (CONVERT(bigint,v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date)
FROM death d JOIN vaccine v 
ON d.date = v.date AND d.location = v.location
WHERE d.continent is NOT NULL 
ORDER BY 2,3