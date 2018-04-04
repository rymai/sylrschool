module Models
  module CommonModels
    public
    # modifie les attributs avant edition
    def self.included(base)
      base.extend(ClassMethods)
    # a appelle extend du sous module ClassMethods sur "base", la classe dans laquelle tu as inclue la lib
    end

    # methodes of class begin
    module ClassMethods
      def get_all
        all.to_a
      end

      def get_all_not_me(object_to_exclude)
        get_all.delete(object_to_exclude)
      end

      #def get_all_names
      #  get_all.map {|r| ["#{r.id}.#{r.name}", r]}
      #get_all.map {|r| [r.name, r]}
      #end

      # for student,responsible,teacher
      def all_person_status
        SYLR::C_ALL_PERSON_STATUS
      end
    end
    # methodes of class end

    # methodes of object begin
    def set_custo
      self.custo=SYLR::CUSTO
    end

    def ident
      "#{id}.#{name}"
    end
  # return the model name in lower case with underscore
  # UserAppli becomes user_appli
  #def modelname
  #  fname = "#{self.class.name}.#{__method__}:"
  #  ret = self.class.name.underscore
  #  ret
  #end

  # methodes of object end
  end
end
