module ApplicationHelper
  def h_img(name, title = nil)
    title = t(File.basename(name.to_s)) if title.nil?
    h_img_base(name, title, 'icone')
  end

  def h_menu(href, _help, title)
    link_to title, href, class: 'menu', id: title, name: title
  end

  private

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
    html << object.description
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
    html << object.description
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

  def h_form_label(form,label)
    html=""
    html << "#{form.label(t(label))}"
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
end