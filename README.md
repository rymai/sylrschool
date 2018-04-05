# SylrSchool : School Management

[![Code Climate](https://codeclimate.com/github/sylvani/sylrschool.png)](https://codeclimate.com/github/sylvani/sylrschool)

## Pré-requis

- OS: linux ou Windows (testé sur Windows 10)
- RubyGems : https://rubygems.org/pages/download
- Ruby 2.4.3
- Rails 4.2.10 
- SGBD PostgreSQL 9.6 (incompatible avec version 10)
- git 2.16.2

## Mise en place

- Cloner le repository git hébergé sur GitHub : 
    `git clone git://github.com/sylvani/sylrschool.git`
- Installer les gems : 
	`cd sylrschool` 
	`bundle install`
  ```
## Setup de développement

- Créer la DB et générer des données de base:
  ```
  rake db:setup
  charger la base avec un exemple de données de base pour une école de type scolaire
  rake sylr:import_custo[db/custos_import,scolaire]
  ```

- Lancer le serveur d'application:
  ```
  rails server
  ```
- [Visiter `localhost:3000`](http://localhost:3000)
- Pour afficher tous les logs de debug, mettre dans les variables d'environnement:
    `SYLRSCHOOL_DEBUG=true` 
    `SYLRSCHOOL_LOG_LEVEL=debug` 


