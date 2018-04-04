#------------------------
pause
set appli=%1
rails new %appli%
cd %appli%
echo Bravo: L'application est cree, Effectuez les taches suivantes apres creation
# modifier Gemfile en ajoutant les gems necessaires
#   note: enlever les #_ pour activer le gem
#==================
# syl added begin
#==================
# See https://github.com/rails/execjs#readme for more supported runtimes
#_  gem 'execjs'
#syl windows gem 'therubyracer'
#syl linux gem 'pg', '0.19.0'
#_  gem 'pg', '~> 0.21.0'
# pour rails4 et les attr_accessible
#_  gem 'protected_attributes'

#you may encounter a TZInfo::DataSourceNotFound exception with the message 
#No source of timezone data could be found . 
#The error indicates that TZInfo was unable to find a source of time zone data on your system. 
#This will typically occur if you are using Windows.
#The simplest way to resolve this error is to install the tzinfo-data gem
#_  gem "tzinfo-data"

#user and connections management
#_  gem 'devise'

# oblige sur windows
#_  gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt' 

#==================
# syl added end
#==================
#
pause
bundle install
bundle update
rails generate scaffold_controller main 
rails generate model session 
rails generate scaffold element name:string:index for_what:string:index description:text custo:string
rails generate scaffold matter_duration name:string:index level_id:integer value:string description:text custo:string
rails generate scaffold responsible name:string:index email:string telephone1:string telephone2:string firstname:string lastname:string adress:string postalcode:string town:string birthday:date description:text custo:string type_id:integer
rails generate scaffold student name:string:index firstname:string telephone1:string telephone2:string lastname:string adress:string postalcode:string town:string birthday:date description:text custo:string 
rails generate scaffold teacher name:string:index firstname:string telephone1:string telephone2:string lastname:string adress:string postalcode:string town:string birthday:date description:text custo:string defmatter_id:integer defgradecontext_id:integer
rails generate scaffold grade_context name:string:index goal:string min_value:string max_value:string description:text custo:string
rails generate scaffold location name:string:index usage_id description:text custo
rails generate scaffold class_school name:string:index nb_max_student:integer default_location_id:bigint description:text custo
rake db:migrate
echo Bravo: La base de données et le framework sont prets, Effectuez les taches suivantes (non exhaustives)

#-----------------------------------
# apres migration, gestion du custo par defaut dans les programmes crees
#
# pour chaque classe du modele
#
#   modifier le model 
#     au debut pour definir le custo
#		include Models::CommonModels
#  		before_save :set_custo
#
#     suivant les attributs
#       validates_presence_of :name, :usage_id
#       validates :name, uniqueness: true
#
#     suivant les relations vers 
#       exemple: belongs_to :usage , class_name: 'Element'
#
#     si besoin, ajouter dans le model une methode effectuant le filtre du polymorphisme pour cette classe
#       modeles concernes:  matter_duration level, present type", responsible type, teaching domain,  locationusage", matter type"
#       def self.location_usages
#         Element.all.where("for_what = 'location_usage' ").to_a
#
#   modifier le view _form
#     mettre des selects pour les relations avec autre objet si elle existe pour cet objet
#       <%= f.label :usage_id %><br>
#       <%= f.collection_select(:usage_id, Location.location_usages, :id, :name) %>
#       attention: remplacer @location.usages par l' objet en cours.elements
#
#   modifier le view show
#     modifier l'affichage des relations
#       <td><%= location.usage.name %></td>
#       attention: remplacer location par l' objet en cours
#  
#   modifier le view index
#     modifier l'affichage des elements en relation
#       <strong>Usage:</strong>
#         <%= @location.usage.name %>
#       end
#       attention: remplacer @location.usage par l' objet en cours.element
#  
#       

#-----------------------------------
#installation du gem devise pour la gestion des users
# voir le site https://github.com/plataformatec/devise
------------------------------------

echo Fin du script %0


