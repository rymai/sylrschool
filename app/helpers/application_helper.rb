module ApplicationHelper
  def h_img(name, title = nil)
    title = t(File.basename(name.to_s)) if title.nil?
    h_img_base(name, title, 'icone')
  end

  def h_menu(href, _help, title)
    link_to title, href, class: 'menu', id: title, name: title
  end

  def h_options_from_collection_for_select(objects, id, name,defo=nil)
    ###puts "========== h_options_from_collection_for_select : objects=#{objects.count}"
    ###puts "========== h_options_from_collection_for_select : id=#{id}, name=#{name},defo=#{defo}"
    ret=""
    # si un seul objet, on en fait une liste
    unless objects.is_a?(Array)
      objects=[objects]
    end
    objects.each do |obj|
      ret<<"\n<option"
      unless defo.nil?
        if(defo.send(id)==obj.send(id))
          ret<<" selected='selected'"
        end
      end
      ret<<" value='#{obj.send(id)}'"
      ret<<">#{obj.send(name)}</option>"
    end
    ###puts "========== h_options_from_collection_for_select:"+ret
    ret.html_safe unless ret.html_safe?
  end

  def h_img_base(name, title, cls)
    ret = "<img class='#{cls}' src='/images/#{name}.png' title='#{title}'/>"
    ret.html_safe unless ret.html_safe?
  end

  def h_show_notice
    html=""
    html << "<p id='notice'>"
    html << "#{notice}"
    html << "</p>"
    html.html_safe
  end

  def get_controller_from_object(object)
    object.model_name.to_s.pluralize.underscore
  end

  def h_show_menus_bottom(object)
    html=""
    html <<"<div class='datagrid-actions'>"
    html << link_to("#{t('action_edit')}", {controller: get_controller_from_object(object), action: :edit, id: object.id})
    html << link_to("#{t('action_index')}", {controller: get_controller_from_object(object), action: :index})
    html << link_to("#{t('action_new')}", {controller: get_controller_from_object(object), action: :new})
    html << "</div>"
    html.html_safe
  end

  def h_show_top(object)
    html=""
    html << "<p>"
    html << "<strong>#{t('label_id')}:</strong>"
    html << object.id
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_name')}:</strong>"
    html << object.name
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_description')}:</strong>"
    html << object.description.to_s
    html << "</p>"
    html.html_safe
  end

  def h_show_topid(object)
    html=""
    html << "<p>"
    html << "<strong>#{t('label_id')}:</strong>"
    html << object.id
    html << "</p>"
    html.html_safe
  end

  def h_show_topidname(object)
    html=""
    html << "<p>"
    html << "<strong>#{t('label_id')}:</strong>"
    html << object.id
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_name')}:</strong>"
    html << object.name
    html << "</p>"
    html.html_safe
  end

  def h_show_topiddescription(object)
    html=""
    html << "<p>"
    html << "<strong>#{t('label_id')}:</strong>"
    html << object.id
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_description')}:</strong>"
    html << object.description.to_s
    html << "</p>"
    html.html_safe
  end

  def h_show_bottom(object)
    html=""
    html << "<p>"
    html << "<strong>#{t('label_custo')}:</strong>"
    html << object.custo
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_created_at')}:</strong>"
    html << object.created_at.to_date.to_s
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_updated_at')}:</strong>"
    html << object.updated_at.to_date.to_s
    html << "</p>"
    html.html_safe
  end

  def h_show_label(label)
    html=""
    html << "<strong>#{t(label)}:</strong>"
    html.html_safe
  end

  def h_form_errors(object)
    html=""
    if object.errors.any?
      html << "<div id='error_explanation'>"
      html << "<h2>#{pluralize(object.errors.count, 'error')} prohibited this #{object.model_name} from being saved:</h2>"
      html << "<ul>"
      object.errors.full_messages.each do |message|
        html << "<li>"
        html << message
        html << "</li>"
      end
      html << "</ul>"
      html << "</div>"
    html.html_safe
    end
  end

  def h_form_label(form,label)
    html=""
    html << "#{form.label(t(label))}"
    html.html_safe
  end

  def h_form_text(form,field,label)
    html=""
    html << "<div class='field'>"
    html << h_form_label(form, label)
    html << form.text_field(field)
    html << "</div>"
    html.html_safe
  end
  def h_form_text_area(form,field,label)
    html=""
    html << "<div class='field'>"
    html << h_form_label(form, label)
    html << form.text_area(field)
    html << "</div>"
    html.html_safe
  end

  def h_form_name(form)
    html=""
    html<< h_form_text(form,:name,:label_name)
    html.html_safe
  end

  def h_form_description(form)
    html=""
    html << "<div class='field'>"
    html << h_form_label(form, :label_description)
    html<< form.cktext_area(:description, id: 'description_id')
    html << "</div>"
    html.html_safe
  end

  def h_form_bottom(form)
    html=""
    html << "<div class='field'>"
    html << form.label(:custo)
    html << form.text_field(:custo)
    html << "</div>"
    html << "<div class='actions'>"
    html << "<div class='datagrid-actions'>"
    html << form.submit
    html << "</div>"
    html << "</div>"
    html.html_safe
  end
  
 #==============================================================================================
 # build a set of links separated by a comma
 # the label of each link is composed of the accessor (attribute of the object) applicated on the object r
 #==============================================================================================
   def h_comma_links(objects, accessor = :ident)
    objects.collect do |o|
      name = o.send(accessor)
      path = send "#{o.class.to_s.underscore}_path", o
      link_to(h(name), path)
    end.join(', ').html_safe
  end
  
  
  #==============================================================================================
  # limite une chaine en n mots avec un suffixe a la fin pour indiquer que le texte est tronque
  #==============================================================================================
  def h_truncate_words(text, len = 5, end_string = " ...")
    return if text.blank?
    words = text.split()
    words[0..(len-1)].join(' ') + (words.length > len ? end_string : '')
  end
  
  #==============================================================================================
  # construit une table simple
  #==============================================================================================
  # argum: cols=[col1,col2,col3], chacune etant une methode de l'objet'
  # argum: adatas=[data2, data2] , chacun etant un objet a afficher sur une ligne
  #==============================================================================================
  # * la 1erer colonne contient toujours un lien vers l'objet
  # * une colonne se terminant par __lnk contient un lien vers l'objet de cette colonne
  #   exemple: h_table(@class_school.students,[:name,:id,:email,:firstname,:lastname,:student_class_school__lnk])
  #   la derniere colonne sera un lien vers la classe du student
  # * une colonne se terminant par __comma contient des liens vers les objets de la colonne separes par des ","
  # * une colonne se terminant par __date contient seulement la date (Annee/Mois/Jour)
  # * une colonne se terminant par __datetime contient le datetime (Annee/Mois/Jour:Heure:Minute)
  # * Si le nombre de lines depasse SYLR::V_TABLE_MAXI_LINES, une ligne avec des ........ est affichée et 
  #   les suivantes sont ignorées
  #==============================================================================================
  def h_table(adatas,cols)
    datas=adatas.to_a 
    ret=""
    #puts "=============== h_table =========== #{datas.size} datas"
    if datas.size>0
      ret<< "<table>"
      ret<< "<tr>"
      # header writing
      cols.each do |column|
        fields=column.to_s.split("__")
        label=t("label_#{fields[0]}")
        ret<< "<th>#{label}</th>"
      end
      ret << "</tr>"
      # lines writing
      # nombre de lignes ecrites
      nbl=1
      datas.to_a.each do |data|
        #puts "=============== h_table =========== #{datas} nbl=#{nbl}, limite=#{SYLR::V_TABLE_MAXI_LINES}"
        if nbl<=SYLR::V_TABLE_MAXI_LINES
          ret << "<tr>"
          cols.count.times do |i|
            colfields=cols[i].to_s.split("__")
            acol=colfields[0]
            ret << "<td>"
            val = data.send(acol)
            #puts "=========== i=#{i} h_table col=#{cols[i]} colfields=#{colfields} acol=#{acol} data=#{data} val=#{val}"
            if i==0
              # lien vers l'objet représenté sur la ligne
              path = send "#{data.class.to_s.underscore}_path", data
              ret << link_to(h(val), path)
            else
              if colfields.size==1
                ret << "#{val}"
              else
                unless val.nil?
                  if colfields[1]=="lnk"
                    #__lnk => on met le lien
                    # lien vers l'objet de la colonne
                    path= send "#{val.class.to_s.underscore}_path", val
                    ret << link_to(h(val.send("ident")), path)
                  elsif colfields[1]=="comma"
                    #__comma => on met les liens, separes par des ,
                    ret << h_comma_links(val, accessor = :ident)
                  elsif colfields[1]=="datetime"
                    #__datetime => on met la date + heure minutes
                    ret << val.to_s[0,val.to_s.size-9]
                 elsif colfields[1]=="date"
                    #__date => on met la date
                    ret << val.to_s.to_date.to_s
                  else
                    #__titi, titi non reconnu=> valeur normale
                    ret<< "#{val}"
                  end
                else
                  ret<< " "
                end
              end
              ret<< "</td>"
            end
          end
          ret<< "</tr>"
        else
          if nbl==datas.count
            # une lignes de ...
            ret << "<tr>"           
            cols.count.times do |i|
              ret << "<td>...</td>"
            end
            ret<< "</tr>"
          end  
        end 
        nbl+=1
      end
      ret<< "</table>"
      ret << "<br>"
      ret.html_safe
    else
      ret
    end
  end
  
  def h_table_class_school(objects)
    h_table(objects,[:name,:id,:nb_max_student,:custo])
  end
  
  def h_table_grade(objects)
    h_table(objects,[:ident,:id,:grade_grade_context__lnk,:grade_matter__lnk,
    :grade_student__lnk,:grade_date,:value])
  end
  
  def h_table_grade_context(objects)
    h_table(objects,[:name,:id,:goal,:min_value,:max_value])
  end
  
  def h_table_location(objects)
    h_table(objects,[:id,:usage__lnk,:location_nb_max_person])
  end
  
  def h_table_matter(objects)
    h_table(objects,[:name,:id,:matter_type__lnk,:matter_duration,:matter_nb_max_student])
  end
  
  def h_table_notebook(objects)
    h_table(objects,[:name,:notebooktext_short,:custo]) 
  end
  
  def h_table_present(objects)
    h_table(objects,[:present_type,:student__lnk])
  end
  
  def h_table_responsible(objects)
    h_table(objects,[:name,:id,:email,:type__link,:firstname,:lastname,:person_status])
  end
  def h_table_responsable_type(objects)
    h_table(objects,[:name,:for_what])
  end
  def h_table_schedule(objects)
    h_table(objects,[:schedule_type,:start_time__datetime,:schedule_father__lnk,:schedule_teaching__lnk])
  end
  
  def h_table_student(objects)
    h_table(objects,[:name,:id,:email,:firstname,:lastname,:student_class_school__lnk])
  end
  
  def h_table_teacher(objects)
    h_table(objects,[:name,:id,:email,:firstname,:lastname,:person_status,:matters__comma])
  end
  
  def h_table_teaching(objects)
    h_table(objects,[:name,:id,:teaching_class_school__lnk,:teaching_teacher__lnk,
    :teaching_matter__lnk,:teaching_domain_ident,:teaching_location__lnk,:teaching_start_time__datetime,:teaching_repetition,
    :teaching_repetition_number]) 
  end

    #
    # == Role: this function permit a selection in a list of objects in another window
    # <em>the field in a first window is updated with the value selected in the second</em>
    #
    # == Arguments
    # * +sym_objfrom+ - \Object name to edit
    # * +sym_objto+ - \Object to select
    # * +val_objtoselect+ - Actual value of the object to select
    # * +:controller+ - Controller of the object to select
    #
    # == Usage
    #
    # === Calling view
    # During datafile edition, I want to choose the responsible:
    # <%= f.label t("label_responsible") %>
    # <%= \select_in_list(:datafile, :owner, @datafile.owner.login, :users) %>
    #
    # === the html result is
    # hidden_field("datafile" , "owner_id")
    # text_field_tag("datafile_owner_display", value of @datafile.owner.login, :disabled => true)
    # link_to(h_img_btn("btn_select"), {:controller => "users", :todo => "select", :html_ident => "datafile_owner"} , {:target => "_blank", :class => 'menu_bas'})"
    #
    # == Impact on other components
    # the 'index' view  of the object to select can be modified to show or not the menus or anything else
    # <% unless param_equals?("todo", "select") %>
    #
    def select_in_list (sym_objfrom, sym_objto, val_objtoselect, controller)
      ret=""
      ret<< hidden_field(sym_objfrom , "#{sym_objto}_id")
      ret<< text_field_tag("#{sym_objfrom}_#{sym_objto}_display", val_objtoselect, :disabled => true)
      ret<< link_to("...", {:controller => controller, :todo => "select", :html_ident => "#{sym_objfrom}_#{sym_objto}"} , {:target => "_blank", :class => 'menu_bas',:title=>t("btn_select")})
      ret.html_safe
    end

    def select_button(object)
      ret=""
      ret<<"<input type='button' value='select' class='btn-select'"
      ret<<" onclick=\"callSelect('#{@myparams["html_ident"]}','#{object.id}','#{object.ident}')\" />"
      ret.html_safe
    end

    #
    # == Role: create two combobox with an arrow to transfer selected values from the left (possible values) to the right (selected values)
    # == Arguments
    # * +form+ Formulaire html created by edition view
    # * +object+ \Object being edited
    # * +values+ Array of objects defining the values
    # * +field+ The field of value to show in select
    # * +assoc_name+ name of the association between object and "object value" / example :ongroup for subscription to groups. Contient le nom de l'association, example :ongroup pour subscription vers les groupes
    # == Usage
    # === Calling view
    # <%= select_inout(form, @subscription, @ongroups, :name, :ongroup) %>
    # Note: in case of no velues, the default is the first object in list of values / Si pas de valeur, on prend le nom par defaut dans la le 1er objet de la liste des valeurs :group
    #
    def select_inout(form, object, values, field, assoc_name=nil)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug (fname){"object=#{object}"}
      #LOG.debug (fname){"values=#{values}, field=#{field}"}
      html = ""
      unless values.nil? || values.count == 0
        #user
        mdl_object=object.class.name.underscore
        #group
        if assoc_name.nil?
        mdl_assoc = values[0].class.name.underscore
        else
        mdl_assoc = assoc_name
        end
        #user_groups
        select_id="#{mdl_object}_#{mdl_assoc}_ids"
        #user[role_ids][]
        select_name="#{mdl_object}[#{mdl_assoc}_ids][]"
        #role_ids
        method=("#{mdl_assoc}_ids").to_sym
       #the_selected=object.method(method).call: ko dans certains cas (securite!!)
        the_selected=object.send(method)
         #label_user_groups_out, label_user_groups_in
        label_out=t("label_"+select_id+"_out")
        label_in=t("label_"+select_id+"_in")
        nb=[values.count+1, 10].min
        html += "<div style='display: none;'>"
        html += form.collection_select(method, values, :id, field, {}, {:id => select_id, :size => nb, :multiple => :true, :name => select_name, :selected => the_selected})
        html += "</div>"
        html += "<table>"
        html += "<tr>"
        html += "<th>#{label_out}</th>"
        html += "<th></th>"
        html += "<th>#{label_in}</th>"
        html += "</tr>"
        html += "<tr>"
        #html += "<td>mdl_object:#{mdl_object} mdl_assoc:#{mdl_assoc} select_id:#{select_id} select_name:#{select_name} method:#{method} : #{the_selected.inspect}</td>"
        html += "<td><select id='#{select_id}_out' multiple='multiple' name='#{select_id}_out' size=#{nb}></select></td>"
        html += "<td><a onclick=\"selectInOutAdd('#{select_id}'); return true;\" title=\"#{t('button_add')}\">#{h_img('select_inout/select_add')}</a>"
        html += "<br/>"
        html += "<a onclick= \"selectInOutRemove('#{select_id}'); return true;\" title=\"#{t('button_remove')}\">#{h_img('select_inout/select_remove')}</a></td>"
        html += "<td><select id='#{select_id}_in' multiple='multiple' name='#{select_id}_in' size=#{nb}></select></td>"
        html += "</tr>"
        html += "</table>"
        html += "<script>selectInOutFill('#{select_id}')</script>"
      end
      html.html_safe
    end

    #
    # combo box: select able to return null value
    #
    def select_with_empty(form, object, attribute, values, id, method)
      # id du select = role_father_id
      select_id = object.class.name.underscore+'_'+attribute.to_s
      html = "<p>#{t(:label_select_active)}</p>"
      html += check_box_tag(:select_active, "no", "false", :onclick=>"selectActive(this, '#{select_id}'); return true;")
      html += form.collection_select(attribute, values, id, method)
      html.html_safe
    end

    # select_relation_attribute(f, @ui_table, @columns, :ident, :ui_column_ids, :rank) %>
    def select_relation_attribute(form, object_from,values,field,relation_name,relation_attribute , nblinesmaxi=20)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug(fname){"=====>object_from=#{object_from.ident}"}
      #LOG.debug(fname){"values=#{values}"}
      #LOG.debug(fname){"field=#{field}"}
      #LOG.debug(fname){"relation_name=#{relation_name}"}
      #LOG.debug(fname){"relation_attribute=#{relation_attribute}"}
      #LOG.debug(fname){"nblinesmaxi=#{nblinesmaxi}"}
      nblines=values.size
      nblines=nblinesmaxi if  nblinesmaxi>20
      ret=""
      unless object_from.nil?
        unless values.blank?
          array_idents=columns_to_array(object_from, values,:ident)
          puts "*********************************array_idents=#{array_idents}"
          #ret+="<br/><table>"
          ret+="<table>"
          #(0..nblines-1).each do |ind|
          ind=0
          array_idents.each do |infocol|
            key=infocol[0]
            #idcol=infocol[1]
            col=UiColumn.find_by_ident(key)
            #LOG.debug(fname){"#{ind} key=#{key} col=#{col.inspect}"}
            idcol=col.id
            # select ident on values
            #LOG.debug(fname){"#{ind} key=#{key} idcol=#{idcol}"}
            default_ident=key
            #LOG.debug(fname){"======== #{ind} array_idents=#{array_idents} default_ident=#{default_ident}"}
            options=options_for_select(array_idents,default_ident)
            puts "*********************************** #{ind} options=#{options}"
            #
            default_rank=idcol
            #LOG.debug(fname){"#{ind} default_rank=#{default_rank}"}
            ret+="<tr>"
            ret += "<td>#{ind}</td>"
            ret += "<td>"
            ret+= select_tag("#{relation_name}[]",options,{autocomplete:"off"})
            ret+="</td>"
            # edit relation attribute
            ret += "<td>"
            ret+= number_field_tag("#{relation_attribute}[]",default_rank,{min:-1,max:nblines})
            ret+="</td>"
            ret += "</tr>"
            ind+=1
          end
          ret+="</table>"
        end
      end
      #LOG.debug(fname){"<=====#{object_from.ident}, field=#{field}, ret=#{ret}"}
      ret.html_safe
    end

    def columns_to_array(object_from, objects, field)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug(fname){"====>#{objects.size} objects"}
      ret=[]
      unless objects.nil?
        ind=0
        objects.each do |obj|
          #LOG.debug(fname){"==== object =#{obj.inspect}"}
          colfieldident=obj.ident
          tabcol=::UiTablesUiColumn.get_from_table_and_colid(object_from, obj.id)
          #LOG.debug(fname){"tabcol=#{tabcol.inspect}"}
          unless tabcol.blank?
          #colfieldvalue=eval "#{tabcol[0]}.#{field}"
          #TODO utiliser eval avec le field
          colfieldvalue= tabcol[0].rank
          colfieldvalue=ind if colfieldvalue.blank?
          #unless (tabcol[0].nil? || tabcol[0].respond_to?( field))
          else
          colfieldvalue=ind
          end
          #LOG.debug(fname){"colfieldident=#{colfieldident} , colfieldvalue=#{colfieldvalue.inspect}"}
          ret << [colfieldident , colfieldvalue]
          ind+=1
        end
      end
      #LOG.debug(fname){"<====#{objects.size} objects, ret=#{ret}"}
      ret
    end

  

end