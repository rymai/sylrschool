# SylrSchool : School Management

[![Code Climate](https://codeclimate.com/github/sylvani/sylrschool.png)](https://codeclimate.com/github/sylvani/sylrschool)

## Pré-requis

- RubyGems : https://rubygems.org/pages/download
- Ruby 2.4.3
- Rails 4.2.10
- SGBD PostgreSQL 9.6 (defaut)
- git 2.16.2

## Mise en place

- Cloner le repository git hébergé sur GitHub : `git clone git://github.com/sylvani/sylrschool.git`
- Installer les gems : `cd sylrschool && bundle install`

## Setup de développement

- Créer la DB et générer des données de base:
  ```
  bin/setup

- Lancer l' app:
  ```
  bin/server
  ```
- [Visiter `localhost:3000`](http://localhost:3000)
- Pour afficher tous les logs de debug, metter `DEBUG=true` dans `.env`

## Déploiement sur Heroku

- [Installer la Heroku Toolbelt](https://toolbelt.heroku.com)
- Enregistrer les remotes de staging et production:
  ```
  heroku git:remote --remote production --app sylrschool
  heroku git:remote --remote staging --app sylrschool-staging
  ```
- Déployer:
  ```
  heroku push staging

  # ou pour déployer une branche particulière en staging
  heroku push staging ma_branche:master

  # ou en production (seulement master donc ne jamais passer ma_branche:master)
  heroku push production
  ```
- Lancer les migrations (si besoin):
  ```
  heroku run rake db:migrate --remote staging

  # ou en production
  heroku run rake db:migrate -r production
  ```
