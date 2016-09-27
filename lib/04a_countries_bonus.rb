# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      non_europe_countries.name
    FROM
      countries AS non_europe_countries
    WHERE
      non_europe_countries.gdp > (
        SELECT
          MAX(europe_countries.gdp)
        FROM
          countries AS europe_countries
        WHERE
          europe_countries.continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      max_countries.continent,
      max_countries.name,
      max_countries.area
    FROM
      countries AS max_countries
    WHERE
      max_countries.area = (
        SELECT
          MAX(all_countries.area)
        FROM
          countries AS all_countries
        WHERE
          all_countries.continent = max_countries.continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      max_countries.name,
      max_countries.continent
    FROM
      countries AS max_countries
    WHERE
      max_countries.population >= 3 * (
        SELECT
          MAX(all_countries.population)
        FROM
          countries AS all_countries
        WHERE
          all_countries.name <> max_countries.name
          AND max_countries.continent = all_countries.continent
      )
  SQL
end
