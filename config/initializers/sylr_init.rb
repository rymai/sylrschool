module SYLR

  ##################################################
  # variables adaptables acceptees par l'application
  ##################################################
  V_ADMIN_EMAIL="sylvere.coutable@laposte.net"
  V_PRESENT_TYPE_PRESENT="present"
  V_PRESENT_TYPE_ABSENT="absent"
  V_PRESENT_TYPE_EXCUSE="excuse"
  V_ALL_PRESENT_TYPES=[V_PRESENT_TYPE_ABSENT,
    V_PRESENT_TYPE_EXCUSE,
    V_PRESENT_TYPE_PRESENT]
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

  ###########################
  # constantes non modiables
  ###########################
  # version
  APP_NAME   = 'SCHOOL'
  #APP_VERSION   = '1.0.1'
  #APP_DATE  = '2018/02/28'.to_date
  APP_VERSION   = '1.0.2'
  APP_DATE  = '2018/04/01'.to_date
  #
  CUSTO='scolaire'
  # repertoires des chargements
  DIR_FIXTURES = "#{Rails.root}/db/fixtures"
  C_LANGUAGE_EN="en"
  C_LANGUAGE_FR="fr"
  C_ALL_LANGUAGES=[C_LANGUAGE_EN,
    C_LANGUAGE_FR]
  #
  # bonnes valeur pour les champs de type check
  C_CHECK_FALSE="false"
  C_CHECK_TRUE="true"

  ###########################################
  #
  # objects names / nom de certains objets
  #
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

  C_SCHEDULE_WORKING="working"
  C_SCHEDULE_HOLIDAY="holiday"
  C_SCHEDULE_PUBLIC_HOLIDAY="public_holiday"
  C_SCHEDULE_WEEKEND="weekend"
  C_SCHEDULE_BRIDGE="bridge"
  C_SCHEDULE_UNWORKING="unworking"
  C_ALL_SCHEDULE_TYPES=[C_SCHEDULE_WORKING,
    C_SCHEDULE_HOLIDAY,
    C_SCHEDULE_PUBLIC_HOLIDAY,
    C_SCHEDULE_WEEKEND,
    C_SCHEDULE_BRIDGE,
    C_SCHEDULE_UNWORKING]

  C_PERSON_STATUS_ENROLLED="enrolled"
  C_PERSON_STATUS_WAITING="waiting"
  C_ALL_PERSON_STATUS=[C_PERSON_STATUS_ENROLLED,
    C_PERSON_STATUS_WAITING]

  C_TEACHING_DAY="day"
  C_TEACHING_WEEK="week"
  C_TEACHING_NONE="none"
  C_ALL_TEACHING_REPETITION=[C_TEACHING_DAY,
    C_TEACHING_WEEK,
    C_TEACHING_NONE]

  #Roles
  C_ROLE_STUDENT= 'student'
  C_ROLE_TEACHER='teacher'
  C_ROLE_RESPONSIBLE='responsible'
  C_ROLE_SUPPORT='support'
  C_ROLE_VISITOR='visitor'
  C_ROLE_ADMIN='admin'
  C_ALL_ROLES=[C_ROLE_STUDENT,
    C_ROLE_TEACHER,
    C_ROLE_RESPONSIBLE,
    C_ROLE_SUPPORT,
    C_ROLE_VISITOR,
    C_ROLE_ADMIN]

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

  C_CTRL_CLASS_USER=[C_CTRL_CLASS_SCHOOLS,
    C_CTRL_CLASS_GRADES,
    C_CTRL_CLASS_MATTERS,
    C_CTRL_CLASS_NOTEBOOKS,
    C_CTRL_CLASS_PRESENTS,
    C_CTRL_CLASS_RESPONSIBLES,
    C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_TEACHERS,
    C_CTRL_CLASS_TEACHINGS]

  C_CTRL_CLASS_ADMIN=[C_CTRL_CLASS_ELEMENTS,
    C_CTRL_CLASS_GRADE_CONTEXTS,
    C_CTRL_CLASS_LOCATIONS]
  C_CTRL_ACTION_GWRITE=["new","create","edit","update","destroy"]
  C_CTRL_ACTION_GREAD=["index","show"]

  C_CTRL_TEACHER_WRITE=[C_CTRL_CLASS_SCHOOLS,
    C_CTRL_CLASS_GRADES,
    C_CTRL_CLASS_MATTERS,
    C_CTRL_CLASS_NOTEBOOKS,
    C_CTRL_CLASS_PRESENTS,
    C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_TEACHERS,
    C_CTRL_CLASS_TEACHINGS]
  C_CTRL_TEACHER_READ=C_CTRL_CLASS_USER

  C_CTRL_RESPONSIBLES_WRITE=[C_CTRL_CLASS_RESPONSIBLES]
  C_CTRL_RESPONSIBLES_READ=C_CTRL_CLASS_USER

  C_CTRL_STUDENTS_WRITE=[C_CTRL_CLASS_STUDENTS,
    C_CTRL_CLASS_NOTEBOOKS]
  C_CTRL_STUDENTS_READ=[C_CTRL_CLASS_USER]

  C_CTRL_VISITORS_WRITE=[]
  C_CTRL_VISITORS_READ=C_CTRL_CLASS_USER.uniq

end

fname = 'sylr_init.rb:'
puts ">>>>#{fname}"

#
# fichier de log specifique
#
logfile       = File.join(Rails.root, 'log', 'sylrschool.log')
LOG           = Logger.new(logfile, 'daily')
# Install custom formatter!
NOLOGS = [
  'titi','toto'
].freeze

puts "#{fname}: SYLRSCHOOL_DEBUG=#{ENV.fetch('SYLRSCHOOL_DEBUG')}"
puts "#{fname}: SYLRSCHOOL_LOG_LEVEL=#{ENV.fetch('SYLRSCHOOL_LOG_LEVEL')}"
if ENV.fetch('SYLRSCHOOL_DEBUG', false) == 'true'
  LOG.formatter = Classes::AppClasses::LogFormatter.new(NOLOGS)
end

# DEBUG INFO WARN ERROR FATAL
LOG.level = Logger.const_get(ENV.fetch('SYLRSCHOOL_LOG_LEVEL', 'error').upcase)
puts "#{fname}: LOG.level=#{LOG.level}"
LOG.info(fname) { 'Lancement SYLRSCHOOL' }
LOG.info(fname) { 'Constantes du module SYLR' }
SYLR.constants.sort.each do |c|
  v = SYLR.const_get(c)
  LOG.debug(fname){"\t#{c}\t\t= #{v}" }
end

LOG.info(fname){ "env=#{Rails.env.inspect} loglevel=#{LOG.level}" }
LOG.info(fname){ '--------------------------------------------' }

puts "<<<<#{fname}"
