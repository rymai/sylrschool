namespace :sylr do
# ruby2  task :load_config => :rails_env do
  task :load_config do
    include ::Rails
    # ruby2 ActiveRecord::Base.configurations = Rails::Configuration.new.database_configuration
    # ActiveRecord::Base.configurations = ::Rails::Application::Configuration.database_configuration()
    ActiveRecord::Base.configurations = Rails.application.config.database_configuration
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Rails.env])
    ActiveRecord::Base.connection.reconnect!
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger.level = Logger::ERROR
    puts "Database configuration=#{ActiveRecord::Base.configurations}"
  end
  desc 'run the scheduler'
  task run_scheduler: [:connect, :environment] do |_t, _args|
  # p Rufus.parse_time_string '500'      # => 0.5
  # p Rufus.parse_time_string '1000'     # => 1.0
  # p Rufus.parse_time_string '1h'       # => 3600.0
  # p Rufus.parse_time_string '1h10s'    # => 3610.0
  # p Rufus.parse_time_string '1w2d'     # => 777600.0

  # p Rufus.to_time_string 60              # => "1m"
  # p Rufus.to_time_string 3661            # => "1h1m1s"
  # p Rufus.to_time_string 7 * 24 * 3600   # => "1w"

  # mm hh jj MMM JJJ tâche
  # mm représente les minutes (de 0 à 59)
  #    hh représente l'heure (de 0 à 23)
  #    jj représente le numéro du jour du mois (de 1 à 31)
  #    MMM représente l'abréviation du nom du mois (jan, feb, ...) ou bien le numéro du mois (de 1 à 12)
  #    JJJ représente l'abréviation du nom du jour ou bien le numéro du jour dans la semaine :
  #        0 = Dimanche
  #        1 = Lundi
  #        2 = Mardi
  #        ...
  #        6 = Samedi
  #        7 = Dimanche (représenté deux fois pour les deux types de semaine)
  # Pour chaque valeur numérique (mm, hh, jj, MMM, JJJ) les notations possibles sont :
  #    * : à chaque unité (0, 1, 2, 3, 4...)
  #    5,8 : les unités 5 et 8
  #    2-5 : les unités de 2 à 5 (2, 3, 4, 5)
  #    */3 : toutes les 3 unités (0, 3, 6, 9...)
  #   10-20/3 : toutes les 3 unités, entre la dixième et la vingtième (10, 13, 16, 19)
    scheduler = Rufus::Scheduler.start_new
    LOG.info(fname) { "Starting Scheduler"}
    # scheduler.cron '0 21 * * 1-5' do
    # every day of the week at 21:00
    scheduler.cron '*/15 7-21 * * 1-5' do
    # every 15 mn of each hour during the week
      LOG.info(fname) { "run task notify"}
      Rake::Task[:notify].invoke
    end
  end

  desc 'notify'
  task notify: [:connect, :environment] do |_t, _args|
    LOG.debug(fname) { "Notification.notify_all"}
    Notification.notify_all(nil)
  end

  desc 'import custo objects : [db/custos_import,scolaire"] or [db/custos_import,musique] or [db/custos_import,clinique] '
  task :import_custo, [:path, :custo] => [:connect, :environment] do |_t, args|
    custo = args.custo.to_s
    path = args.path.to_s
    site = args.site.to_s
    fname = "#{self.class.name}.#{__method__}"
    LOG.debug(fname) { "path is #{path}, custo is #{custo}" }
    fixtures_path = "#{path}/#{custo}"
    if custo.empty?
      LOG.error(fname) { "Path and Custo are mandatory"}
    else
      ENV['FIXTURES_PATH'] = fixtures_path
      LOG.debug(fname) { "fixtures_path=#{ENV['FIXTURES_PATH']}, metadata loading" }
      begin
        Rake::Task['db:fixtures:load'].invoke
      rescue Exception => e
        LOG.debug(fname) { "ERROR during Rake::Task[db:fixtures:load].invoke : #{e.inspect}" }
      end
      LOG.debug(fname) { "Metadata from custo '#{custo}' loading terminated" }
    end
  end

  desc 'Truncate all tables'
  task truncate: :connect do
    truncate
  end

  desc 'export custo objects : [db/custos_export,scolaire"] or [db/custos_export,musique] or [db/custos_export,clinique] '
  task :export_custo, [:path, :custo] => [:connect, :environment] do |_t, args|
    custo = args.custo.to_s
    path = args.path.to_s
    fname = "#{self.class.name}.#{__method__}"
    LOG.debug(fname) {  "path is #{path}, custo is #{custo}"}
    if custo.empty?
      LOG.debug(fname) { "Custo is mandatory"}
    else
      fixtures_path = "#{path}/#{custo}"
      FileUtils.mkdir_p fixtures_path
      export_custo custo, fixtures_path
    end
  end

  task connect: :load_config do
    ActiveRecord::Base.establish_connection
  end

  def truncate
    config = ActiveRecord::Base.configurations[RAILS_ENV]
    case config['adapter']
    when 'mysql'
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
      end
    when 'sqlite', 'sqlite3'
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
        ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
      end
      ActiveRecord::Base.connection.execute('VACUUM')
    end
  rescue StandardError
    warn 'Error while truncating. Make sure you have a valid database.yml file and have created the database tables before running this command. You should be able to run rake db:migrate without an error'
    end

  # export of models data
  #
  def export_custo(acusto, fixtures_path)
    fname = "#{self.class.name}.#{__method__}"
    models = load_models
    unless models.nil?
      #
      assocs = {}
      FileUtils.remove(Dir.glob("#{fixtures_path}/*"))
      custos = []
      custos << acusto
      stars = "*********************************************\n"
      LOG.debug(fname) { stars }
      LOG.debug(fname) { "custos:#{custos}, #{models.size} modeles" }
      custos.each do |custo|
        LOG.debug(fname) { "custo:#{custo} -------------------------------" }
        # models=ActiveRecord::Base.subclasses
        models.each do |model|
          begin
            LOG.debug(fname) { ".................. custo:#{custo} , model:#{model} with #{model.count} records" }
            assocs.merge(export_model(model, fixtures_path, custo))
          rescue Exception => e
            LOG.error(fname) { "#{fname}: ERROR:#{e}"}
          end
        end
      end
      LOG.debug(fname) { stars }
      LOG.debug(fname) { 'Writing associations' }
      assocs.keys.each do |key|
        export_association key, custo
      end
      LOG.debug(fname) { stars }
      LOG.debug(fname) { 'Cleaning empty files' }
      Dir.glob("#{fixtures_path}/*.yml").each do |afile|
        asize = File.size(afile)
        msg = "verify file:#{afile}:#{asize}"
        if asize == 0
          File.unlink(afile)
          msg += ':deleted'
        end
        LOG.debug(fname) { "Clean: #{msg}"}
      end
    end
  end

  def export_associations(key)
    fname = "#{self.class.name}.#{__method__}"
    out_yml = File.open("#{fixtures_path}/#{key}.yml", 'w')
    LOG.debug(fname) { "Opening #{out_yml.inspect} "}
    assocs[key].each do |assoc|
      str = ''
      head = ''
      assoc.keys.each do |akey|
        head << '_' if head != ''
        head << "#{akey}_#{assoc[akey]}"
        str << "  #{akey}: #{assoc[akey]}\n"
      end
      out_yml.write "#{head}:\n"
      out_yml.write "#{str}\n"
    end
    begin
      out_yml.close
    rescue Exception => e
      LOG.debug(fname) { "Error during export_custo:#{e}"}
      print_stack e
    end
  end

  def export_model(model, fixtures_path, custo)
    fname = "#{self.class.name}.#{__method__}"
    assocs = {}
    nl = "\n"
    begin
      reflections = model.reflect_on_all_associations(:has_and_belongs_to_many)
      # model attributs list
      cols = []
      model.columns.each do |col|
        cols<<"#{col.name}" unless %w[id created_at updated_at].include?(col.name)
      end
      # take only model with custo attribut and some records
      col_custo="custo"
      ismodeluser=model.to_s == "User"
      iscustodata=cols.include?(col_custo)  || ismodeluser
      if iscustodata
        nb = model.all.size
        if nb > 0
          # opening output file
          out_yml = File.open("#{fixtures_path}/#{model.name.underscore}s.yml", 'w')
          LOG.info(fname) { "Opening #{out_yml.inspect}"}
          objs = model.all
          objs.each do |obj|
          # only if data is declared on a custo
            if(ismodeluser)
            objcusto=custo
            else
            objcusto=obj.custo
            end
            if objcusto == custo
              out_yml.write("#{nl}#{model}_#{obj.id}:#{nl}")
              yml = obj.attributes.to_yaml
              lines = yml.split(nl)
              lines.each do |line|
                out_yml.write('  ' + line + nl) if line != '---'
              end
              reflections.each do |r|
                export_reflection obj, r, fixtures_path, assocs
              end
            else
              LOG.warn(fname) { "#{obj} in custo '#{objcusto}' <> '#{custo}' model='#{model}'"}
            end
          end
          #
          begin
            out_yml.close
          rescue Exception => e
            LOG.error(fname) { "Error during export_custo:#{e}"}
            print_stack e
          end
          out_yml = nil
        #
        else
          LOG.debug(fname){"Modele #{model} non pris en compte car vide ,  nb=#{nb}"}
        end
      else
        LOG.debug(fname){"Modele #{model} non pris en compte car pas de colonne #{col_custo}, iscustodata=#{iscustodata} "}
      iscustodata
      end
    rescue Exception => e
      LOG.debug(fname) { "Error during export_custo:#{e}"}
      print_stack e
    end
    begin
      out_yml.close unless out_yml.nil?
    rescue Exception => e
      LOG.debug(fname) { "Error during export_custo:#{e}"}
      print_stack e
    end
    assocs
  end

  def print_stack e
    stack = ''
    e.backtrace.each do |x|
      LOG.debug(fname) { x + "\n"}
    end
  end

  def export_reflection(obj, r, fixtures_path, assocs)
    fname = "#{self.class.name}.#{__method__}"
    rname = r.name.to_s
    rname = rname.chop if rname[rname.length - 1, 1] == 's'
    ext_ids = obj.send("#{rname}_ids")
    if ext_ids.count > 0
      rel_yml = File.open("#{fixtures_path}/#{r.options[:join_table]}.yml", 'a')
      ext_ids.each do |ext_id|
        assocs[r.options[:join_table]] = [] if assocs[r.options[:join_table]].nil?
        trouve = false
        assocs[r.options[:join_table]].each do |arel|
          if arel[r.association_foreign_key] == obj.id && arel[r.primary_key_name] == ext_id ||
          arel[r.primary_key_name] == obj.id && arel[r.association_foreign_key] == ext_id
          trouve = true
          end
        end
        unless trouve
          begin
            assocs[r.options[:join_table]] << { r.primary_key_name => obj.id, r.association_foreign_key => ext_id, :custo => custo }
          rescue Exception => e
          end
        end
        rel_yml.write "#{r.primary_key_name}_#{obj.id}_#{r.association_foreign_key}_#{ext_id}:\n"
        rel_yml.write "  #{r.primary_key_name}: #{obj.id}\n"
        rel_yml.write "  #{r.association_foreign_key}: #{ext_id}\n"
      end
      begin
        rel_yml.close
      rescue Exception => e
        LOG.debug(fname) { "Error during export_custo:#{e}"}
        print_stack e
      end
    end
  end

  def load_models
    fname = "#{self.class.name}.#{__method__}"
    # loading models
    models = []
    Dir.glob("#{Rails.root}/app/models/*.rb").each do |file|
      begin
        LOG.debug(fname) { "file model=#{file}" }
        require file
        fields = file.split('/')
        afile = File.new(file)
        basename = File.basename(file)
        basename = basename.gsub('.rb', '')
        LOG.debug(fname) { "filename=#{basename}" }
        model = eval basename.camelize
        models << model
        LOG.debug(fname) { "model=#{model}" }
      rescue Exception => e
      # stack=""
      # e.backtrace.each { |x|
      # stack+= x+"\n"
      # }
        LOG.debug(fname) { "Warning loading model(#{file}):#{e}}" }
      end
    end
    LOG.debug(fname) { "models=#{models}" }
    models
  end
end
