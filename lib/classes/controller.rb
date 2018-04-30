#require 'active_record/fixtures'
#require 'populate'
class Controller
  attr_accessor :id, :name, :method
  def initialize(i_id,i_name,i_method)
    @id=i_id
    @name=i_name
    @method=i_method
  end

  def name_method
    ret=@name+"."+@method
    ret
  end

  def self.get_controllers_and_methods
    fname = "#{self.class.name}.#{__method__}"
    controllers_and_methods = []

    Dir.glob(Rails.root.join('app/controllers', '**', '*_controller.rb')).each_with_index do |file, index|
      ###puts "Controller.get_controllers:"+controller
      controller = File.basename(file, '.rb').camelize
      controller_class = controller.safe_constantize
      next unless controller_class

      controller_class.instance_methods(false).sort.each do |smet|
        next if controller == 'ApplicationController'

        method = smet.to_s

        if controller != 'SessionsController' &&
           (
             %w[init_objects login logout].include?(method) ||
             method =~ /(_old|authorized)($|_obsolete$|_$)/
           )
          next
        end

        controllers_and_methods << Controller.new(index, controller, method)
      end
    end
    LOG.debug(fname) { "Number of controllers and methods=#{controllers_and_methods.count}" }

    controllers_and_methods
  end

  def self.route_exists?(controller, action)
    fname= "#{self.class.name}.#{__method__}"
    cont = "#{controller}_controller".camelize
    LOG.debug(fname){"Controller.route_exists? controller=#{controller} , cont=#{cont} , action=#{action})"}
    methods=eval("::#{cont}.new.methods")
    #LOG.debug(fname){"Controller.route_exists?:methods=#{methods}"}
    ret = methods.include? action.to_sym
    LOG.debug(fname){"Controller.route_exists?(#{cont}, #{action.to_sym})=#{ret}"}
    ret
  end

  def self.get_types_by_features(only_admin=false)
    fname="Controller.#{__method__}"
    LOG.info(fname) { "only_admin=#{only_admin}"}
    ret={}
    # TODO temporary
    features = [:document, :part, :project, :customer]
    features_types = {}
    features.each do |feature|
      features_types[feature]=[]
      # TODO temporary
      plmtype = feature
      # types, including the generic one
      types = ::Typesobject.get_types(plmtype, false)
      LOG.debug(fname) {"types for #{feature}=#{types}l"}
      types.each do |type|
        if !only_admin || type.domain==::SYLRPLM::DOMAIN_ADMIN
          unless type.nil?
          features_types[feature] << type
          else
            LOG.error(fname) {"Error:  a type of #{feature} is nil"}
          end
        end
      end
      features_types[feature].sort! do |type1 , type2|
        mdl1 = type1.forobject+"s"
        mnu1=tr_def("mnu_#{mdl1}_#{type1.name}")
        mdl2 = type2.forobject+"s"
        mnu2=tr_def("mnu_#{mdl2}_#{type2.name}")
        compare=mnu1 <=> mnu2
        LOG.info(fname) { "compare:#{mnu1}<=>#{mnu2}=#{compare}"}
        compare
      end
      generic_type = Typesobject.generic(feature)
      divider=Typesobject.new ({:name=>"divider",:forobject=>feature})
      ret[feature]=[]
      ret[feature] << generic_type
      ret[feature] << divider
      features_types[feature].each do |menus|
        ret[feature] << menus
      end

    end
    LOG.debug(fname) {"ret=#{ret}"}
    ret
  end

  def self.tr_def(key)
    ::PlmServices.translate(key,:default=> "%#{key}%")
  end
end
