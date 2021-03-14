-- Exercices SQL – Base de données des villes de France

-- https://sql.sh/exercices-sql/villes-de-france
-- l convient de télécharger les bases de données d’exemples, qui seront utilisées au sein des exercices.
-- Table “villes de France” (8.4Mo)
-- Table “départements de France” (7.9Ko)

-- Veuillez trouver les requêtes SQL permettant d’effectuer chacune des demandes suivantes :

-- 1  Obtenir la liste des 10 villes les plus peuplées en 2012
SELECT ville_nom, ville_population_2012
FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10
-- résultat :
-- PARIS, MARSEILLE, LYON, TOULOUSE, NICE, NANTES, STRASBOURG, MONTPELLIER, BORDEAUX, LILLE

-- 2  Obtenir la liste des 50 villes ayant la plus faible superficie
SELECT ville_nom, ville_surface
FROM villes_france_free
ORDER BY ville_surface ASC 
LIMIT 50
-- résultat trop long

-- 3  Obtenir la liste des départements d’outres-mer, 
--   c’est-à-dire ceux dont le numéro de département commencent par “97”
SELECT *
FROM departement
WHERE departement_code LIKE '97%'
-- résultat :
-- Mayotte, Guadeloupe, Guyane, Martinique, Réunion

-- 4  Obtenir le nom des 10 villes les plus peuplées en 2012, 
--   ainsi que le nom du département associé
SELECT ville_nom, ville_population_2012, departement_code
FROM villes_france_free v, departement d
WHERE d.departement_code = v.ville_departement
ORDER BY ville_population_2012 DESC
LIMIT 10
-- autre solution :
SELECT * 
FROM `villes_france_free` 
LEFT JOIN departement ON departement_code = ville_departement
ORDER BY `ville_population_2012` DESC 
LIMIT 10
-- résultat :
-- PARIS 75, MARSEILLE 13, LYON 69, TOULOUSE 31, NICE 06, 
-- NANTES 44, STRASBOURG 67, MONTPELLIER 34, BORDEAUX 33, LILLE 59

-- 5  Obtenir la liste du nom de chaque département, 
-- associé à son code et du nombre de commune au sein de ces département, 
-- en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes
SELECT d.departement_nom, d.departement_code, COUNT(v.ville_id) AS nbCommunes
FROM departement d, villes_france_free v
WHERE d.departement_code = v.ville_departement
GROUP BY d.departement_nom, d.departement_code
ORDER BY nbCommunes DESC 
-- résultat trop long, début : Pas-de-Calais, Aisne, Somme, Seine-Maritime, Moselle ... 
-- autre solution :
SELECT departement_nom, ville_departement, COUNT(*) AS nbr_items 
FROM `villes_france_free` 
LEFT JOIN departement ON departement_code = ville_departement
GROUP BY ville_departement, departement_nom
ORDER BY `nbr_items` DESC

-- 6  Obtenir la liste des 10 plus grands départements, en terme de superficie

-- 7  Compter le nombre de villes dont le nom commence par “Saint”

-- 8  Obtenir la liste des villes qui ont un nom existants plusieurs fois, 
-- et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes

-- 9  Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne

-- 10  Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants

-- 11  Remplacez les tirets par un espace vide, 
-- pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule)