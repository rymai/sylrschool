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
        #puts "=============== h_table =========== #{datas.size} nbl=#{nbl}, limite=#{SYLR::V_TABLE_MAXI_LINES}"
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
                    #__datetime => on met la date
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

end