module SYLR

  ##############################################################################################
  # Variables adaptables acceptees par l'application
  ##################################################
  # Les constantes commençant par V_ peuvent être modifiées AVANT l'utilisation de l'application.
  # Par contre, les constantes commençant par C_ ne doivent pas être modifiées car elles sont 
  #   traitées par les algorithme de l'applicationl.
  ##############################################################################################
  # nom de l'ecole
  V_APP_NAME   = 'SCHOOL'
  #V_APP_VERSION   = '1.0.1'
  #V_APP_DATE  = '2018/02/28'.to_date
  #V_APP_VERSION   = '1.0.2'
  #V_APP_DATE  = '2018/04/01'.to_date
  V_APP_VERSION   = '1.0.3'
  V_APP_DATE  = '2018/05/05'.to_date
  
  # nom du paramétrage
  # ATTENTION, il faut le changer avant de créer le 1er objet dans l'application.
  V_APP_CUSTO='scolaire'

  # valeurs du type de Presence
  V_PRESENT_TYPE_PRESENT="present"
  V_PRESENT_TYPE_ABSENT="absent"
  V_PRESENT_TYPE_EXCUSE="excuse"
  V_ALL_PRESENT_TYPES=[V_PRESENT_TYPE_ABSENT,
    V_PRESENT_TYPE_EXCUSE,
    V_PRESENT_TYPE_PRESENT]

  # valeurs des themes, la valeur par defaut C_DEFAULT_THEME peut être modifiée pour une des valeurs constantes ci dessous
  # WARNING, seule le thme white est complet et testé.
  C_THEME_WHITE="white"
  C_THEME_BLUE="blue"
  C_THEME_GREEN="green"
  C_THEME_BLACKWHITE="blackwhite"
  C_ALL_THEMES=[C_THEME_WHITE,
    C_THEME_BLUE,
    C_THEME_GREEN,
    C_THEME_BLACKWHITE
  ]
  V_DEFAULT_THEME=C_THEME_WHITE

  # nombre maxi de lignes dans les listes simples affiches dans les fiches (show)
  V_TABLE_MAXI_LINES=10
  
  ####################################################################################
  # Constantes non modiables.
  ###########################
  # Ces constantes commençant par C_ ne doivent pas être modifiées car elles sont 
  #   traitées par les algorithmes de l'application.
  ####################################################################################

  # les langages implémentés
  C_LANGUAGE_EN="en"
  C_LANGUAGE_FR="fr"
  C_ALL_LANGUAGES=[C_LANGUAGE_EN,
    C_LANGUAGE_FR]
  #
  # bonnes valeur pour les champs de type check
  C_CHECK_FALSE="false"
  C_CHECK_TRUE="true"

  ###########################################################
  # Constantes relatives aux différents objet de l'application
  ###########################################################
  # Elements for_whats
  C_FOR_WHAT_RESPONSIBLE_TYPE="responsible_type"
  C_FOR_WHAT_TEACHING_DOMAIN="teaching_domain"
  C_FOR_WHAT_LOCATION_USAGE="location_usage"
  C_FOR_WHAT_MATTER_TYPE="matter_type"
  C_FOR_WHAT_CALENDAR_BEGIN="calendar_begin"
  C_FOR_WHAT_CALENDAR_END="calendar_end"
  C_ALL_ELEMENT_FOR_WHATS=[C_FOR_WHAT_RESPONSIBLE_TYPE,
    C_FOR_WHAT_TEACHING_DOMAIN,
    C_FOR_WHAT_LOCATION_USAGE,
    C_FOR_WHAT_MATTER_TYPE,
    C_FOR_WHAT_CALENDAR_BEGIN,
    C_FOR_WHAT_CALENDAR_END
  ]
  # les types d'horaires
  C_SCHEDULE_WORKING="working"
  C_SCHEDULE_HOLIDAY="holiday"
  C_SCHEDULE_PUBLIC_HOLIDAY="public_holiday"
  C_SCHEDULE_WEEKEND="weekend"
  C_SCHEDULE_BRIDGE="bridge"
  C_SCHEDULE_UNWORKING="unworking"
  C_ALL_SCHEDULE_TYPES=[C_SCHEDULE_WEEKEND,
    C_SCHEDULE_HOLIDAY,
    C_SCHEDULE_PUBLIC_HOLIDAY,
    C_SCHEDULE_BRIDGE,
    C_SCHEDULE_UNWORKING,
    C_SCHEDULE_WORKING]
  
  # valeur par defaut d'un enseignement (teaching)
  C_INDIC_DAY_SCHEDULE=-1
  # valeur par defaut d'un horaire (schedule) qui a des "fils" (de type weekend et holidays)
  C_INDIC_SCHEDULE_FATHER=-2

  # les differents statuts des personnes
  C_PERSON_STATUS_ENROLLED="enrolled"
  C_PERSON_STATUS_WAITING="waiting"
  C_ALL_PERSON_STATUS=[C_PERSON_STATUS_ENROLLED,
    C_PERSON_STATUS_WAITING]

  # les frequences de repetition des enseignements sur le calendrier
  C_TEACHING_DAY="day"
  C_TEACHING_WEEK="week"
  C_TEACHING_NONE="none"
  C_ALL_TEACHING_REPETITION=[C_TEACHING_DAY,
    C_TEACHING_WEEK,
    C_TEACHING_NONE]

  #les roles
  C_ROLE_STUDENT= 'student'
  C_ROLE_TEACHER='teacher'
  C_ROLE_RESPONSIBLE='responsible'
  # le support a accès à tous les objets
  C_ROLE_SUPPORT='support'
  C_ROLE_VISITOR='visitor'
  # l'admin a acces aux objets de paramétrage
  C_ROLE_ADMIN='admin'
  C_ALL_ROLES=[C_ROLE_STUDENT,
    C_ROLE_TEACHER,
    C_ROLE_RESPONSIBLE,
    C_ROLE_VISITOR,
    C_ROLE_ADMIN,
    C_ROLE_SUPPORT]

  # pour action controller user fonction du role
  C_CTRL_CLASS_SCHOOLS="class_schools"
  C_CTRL_CLASS_GRADES="grades"
  C_CTRL_CLASS_MATTERS="matters"
  C_CTRL_CLASS_NOTEBOOKS="notebooks"
  C_CTRL_CLASS_PRESENTS="presents"
  C_CTRL_CLASS_RESPONSIBLES="responsibles"
  C_CTRL_CLASS_STUDENTS="students"
  C_CTRL_CLASS_TEACHERS="teachers"
  C_CTRL_CLASS_TEACHINGS="teachings"

  # pour action controller admin fonction du role
  C_CTRL_CLASS_ELEMENTS="elements"
  C_CTRL_CLASS_GRADE_CONTEXTS="grade_contexts"
  C_CTRL_CLASS_LOCATIONS="locations"

  # les objets lies au fonctionnement de l'ecole
  C_CTRL_CLASS_USER=[C_CTRL_CLASS_SCHOOLS,
    C_CTRL_CLASS_GRADES,
    C_CTRL_CLASS_MATTERS,
    C_CTRL_CLASS_NOTEBOOKS,
    C_CTRL_CLASS_PRESENTS,
    C_CTRL_CLASS_RESPONSIBLES,
    C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_TEACHERS,
    C_CTRL_CLASS_TEACHINGS]

  # les objets lies au parametrege suivant les besoins de l'ecole
  C_CTRL_CLASS_ADMIN=[C_CTRL_CLASS_ELEMENTS,
    C_CTRL_CLASS_GRADE_CONTEXTS,
    C_CTRL_CLASS_LOCATIONS]
  # l'ensemble des objets
  C_CTRL_CLASS_ALL=C_CTRL_CLASS_ADMIN.concat(C_CTRL_CLASS_USER)

  # les actions de type ecriture
  C_CTRL_ACTION_GWRITE=["new","create","edit","update","destroy"]
  # les actions de type lecture
  C_CTRL_ACTION_GREAD=["index","show"]

  #les objets en écriture et lecture pour le professeur
  C_CTRL_TEACHER_WRITE=[C_CTRL_CLASS_SCHOOLS,
    C_CTRL_CLASS_GRADES,
    C_CTRL_CLASS_MATTERS,
    C_CTRL_CLASS_NOTEBOOKS,
    C_CTRL_CLASS_PRESENTS,
    C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_TEACHERS,
    C_CTRL_CLASS_TEACHINGS]
  C_CTRL_TEACHER_READ=C_CTRL_CLASS_USER

  #les objets en écriture et lecture pour le responsable
  C_CTRL_RESPONSIBLES_WRITE=[C_CTRL_CLASS_RESPONSIBLES]
  C_CTRL_RESPONSIBLES_READ=C_CTRL_CLASS_USER

  # les objets en écriture et lecture pour le professeur
  C_CTRL_STUDENTS_WRITE=[C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_NOTEBOOKS]
  C_CTRL_STUDENTS_READ=[C_CTRL_CLASS_USER]

  # les objets en écriture et lecture pour le visiteur
  C_CTRL_VISITORS_WRITE=[]
  C_CTRL_VISITORS_READ=C_CTRL_CLASS_USER.uniq

end

# traces
fname = 'sylr_init.rb:'
puts ">>>>#{fname}"

################################################################
# fichier de log specifique et création du driver des logs (LOG)
################################################################
logfile       = File.join(Rails.root, 'log', 'sylrschool.log')
LOG           = Logger.new(logfile, 'daily')
# Les lignes contenant les mots suivants ne seront pas affichées
NOLOGS = [
  'titi','toto'
].freeze

##########################################################################
# Activation des logs
######################
# Par defaut (en production par exemple, le debug est désactivée.
# Pour les autres environnement, si la variable d'environnement Windows ou 
#   linus SYLRSCHOOL_DEBUG est declarée avec la valeur true, 
#   l'affichage des logs est effectué.
##########################################################################
#puts "#{fname}: SYLRSCHOOL_DEBUG=#{ENV.fetch('SYLRSCHOOL_DEBUG')}"

#if ENV.fetch('SYLRSCHOOL_DEBUG', false) == 'true'
  LOG.formatter = Classes::AppClasses::LogFormatter.new(NOLOGS)
#end

##########################################################################
# Niveau du debug
##################
# Par defaut (en production par exemple, le niveau est error)
# Pour les autres environnement, si la variable d'environnement Windows ou 
#   linus SYLRSCHOOL_LOG_LEVEL est declarée avec une des valeurs 
#   ci dessous, ce niveau sera utilisé. 
# DEBUG INFO WARN ERROR FATAL
##########################################################################
#puts "#{fname}: SYLRSCHOOL_LOG_LEVEL=#{ENV.fetch('SYLRSCHOOL_LOG_LEVEL')}"
###LOG.level = Logger.const_get(ENV.fetch('SYLRSCHOOL_LOG_LEVEL', 'error').upcase)
LOG.level = Logger.const_get('debug').upcase
puts "#{fname}: LOG.level=#{LOG.level}"
LOG.info(fname) { 'Lancement SYLRSCHOOL' }

#############################################
# La liste des constantes est affichée
#############################################
LOG.info(fname) { 'Constantes du module SYLR' }
SYLR.constants.sort.each do |c|
  v = SYLR.const_get(c)
  LOG.debug(fname){"\t#{c}\t\t= #{v}" }
end
###############
# informations
###############
LOG.info(fname){ "env=#{Rails.env.inspect} loglevel=#{LOG.level}" }
LOG.info(fname){ '--------------------------------------------' }

puts "<<<<#{fname}"
