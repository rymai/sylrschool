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
    html << object.created_at.to_s
    html << "</p>"
    html << "<p>"
    html << "<strong>#{t('label_updated_at')}:</strong>"
    html << object.updated_at.to_s
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
  def h_form_description_old(form)
    html=""
    html<< h_form_text_area(form,:description,:label_description)
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
  
  # build a set of links separated by a comma
  # the label of each link is composed of the accessor (attribute of the object) applicated on the object r
  def h_comma_links(objects, accessor = :ident)
    objects.collect do |o|
      name = o.send(accessor)
      path = send "#{o.class.to_s.underscore}_path", o
      link_to(h(name), path)
    end.join(', ').html_safe
  end
  
  def h_truncate_words(text, len = 5, end_string = " ...")
    return if text.blank?
    words = text.split()
    words[0..(len-1)].join(' ') + (words.length > len ? end_string : '')
  end
  
  # construit une table simple
  # cols=[col1,col2,col3], chacune etant une methode de l'objet'
  # datas=[data2, data2] , chacun etant un objet a afficher sur une ligne
  def h_table(datas,cols)
    datas=datas.to_a
    ret=""
    puts "=============== h_table =========== #{datas.size} datas"
    if datas.size>0
       ret<< "<table>"
      ret<< "<tr>"
      cols.each do |column|
        label=t("label_#{column}")
        ret<< "<th>#{label}</th>"
      end
      ret<< "</tr>"
      datas.to_a.each do |data|
        ret<< "<tr>"
        cols.count.times do |i|
          acol=cols[i]
          ret<< "<td>"
          val = data.send(acol)
          if i==0
            path = send "#{data.class.to_s.underscore}_path", data
            ret<< link_to(h(val), path)
          else
            ret<< "#{val}"
            ret<< "</td>"
          end
        end
        ret<< "</tr>"
      end
      ret<< "</table>"
      ret << "<br>"
      ret.html_safe
    else
      ret
    end
  end

end