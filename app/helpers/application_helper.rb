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

end
