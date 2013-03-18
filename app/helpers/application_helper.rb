module ApplicationHelper
  def page_title title, in_page = true
    set_meta_tags :site => t('app_name'), :title => title, :reverse => true
    content_for(:head_title) { title }
    if in_page == true
      content_for(:page_title) { title }      
    end
  end
  
  def url_for_asset type, source
    URI.join root_url, send("#{ type }_path", source)
  end
  
  def url_for_image source
    url_for_asset 'image', source
  end
  
  def link_to_nav(name, options = {}, html_options = {}, &block)
    output = '<li'.html_safe
    css = []
    css << ' class="'
    if current_page?(options)
      css << 'active'
    end
    css << '"'
    output << css.join(' ').html_safe
    output << '>'.html_safe
    unless html_options[:icon].nil?
      name = "<i class=\"icon-#{html_options[:icon]}\"></i> <span class=\"title\">#{name}</span>".html_safe
      html_options.delete :icon
    end
    unless html_options[:image].nil?
      name = (image_tag html_options[:image], :class => 'group-image-icon').html_safe + "<span class=\"title\">#{name}</span>".html_safe
      html_options.delete :image
    end
    unless html_options[:counter].nil?
      if html_options[:counter] > 0
        name << "<span class=\"pull-right badge\">#{html_options[:counter]}</span>".html_safe
      end
      html_options.delete :counter
    end
    unless html_options[:help].nil?
      name << "<span class=\"help-block\">#{html_options[:help]}</span>".html_safe
      html_options.delete :help
    end
    output << link_to(name, options, html_options, block)
    output << '</li>'.html_safe
    output
  end
  
  def render_block(title = nil, options = {}, &block)
    buffer = ''.html_safe
    buffer << "<section class=\"block clearfix #{ options[:class] }\">".html_safe
    if block_given?
      contents = capture(&block) 
    end
    unless title.nil?
      unless contents.nil?
        buffer << '<header class="collapsible">'.html_safe
      else
        buffer << '<header>'.html_safe
      end
      buffer << title.html_safe
      unless options[:more].nil?
        buffer << '<span class="more">'.html_safe
        buffer << options[:more].html_safe
        buffer << '</span>'.html_safe
      end
      buffer << '</header>'.html_safe
    end
    unless contents.nil?
      buffer << '<div class="block-content">'.html_safe
      buffer << '  <ul class="nav nav-list">'.html_safe    
      buffer << contents.html_safe
      buffer << '  </ul>'.html_safe
      buffer << '</div>'.html_safe    
    end
    buffer << '</section>'.html_safe
    buffer.html_safe
  end
  
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end
  
  def time_ago datetime
    "<time class=\"timeago\" datetime=\"#{datetime.to_time.iso8601}\">#{t('time_ago_html', :time => time_ago_in_words(datetime))}</time>".html_safe
  end
  
  def bidi_filter str
    str.gsub! /\r\n?/, "\n"
    str.gsub! /\n+/, "\n"
    output = ''
    
    dir = 'ltr'
    in_paragraph, in_span = false, false
    str.each_char do |c|
      if c.index /([\u0590-\u05FF\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF\u200F])/
        output << '</span>'.html_safe if in_span && dir == 'ltr'
        dir = 'rtl'
      else
        output << '</span>'.html_safe if in_span && dir == 'rtl'
        dir = 'ltr'
      end
      unless in_paragraph
        output << "<p style=\"direction:#{ dir }\">".html_safe
        in_paragraph = true
        in_span = true
      end
      unless in_span
        output << "<span style=\"direction:#{ dir }\">".html_safe
        in_span = true
      end
      if c == "\n"
        output << '</p>'.html_safe
        in_paragraph = false
      else
        output << c
      end
    end
    output.html_safe
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
