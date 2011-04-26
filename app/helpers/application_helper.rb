module ApplicationHelper
  
  def short_text(text,length=20)
    text.mb_chars.slice(0..length).to_s.lstrip + (text.mb_chars[length].nil?? "" : "...") if text
  end
  
  def error_explanation_for(object)
    html = '<ul id="error_explanation">'
    object.errors.each do |msg|
      html << "<li>#{msg[1]}</li>"
    end
    html << '</ul>'
  end
  
  def personal_name(user)
    (current_user == user) ? "我" : user.login
  end
  
  def format_date(date)
    "#{date.year == Date.today.year ? '' : "#{date.year}年"}#{date.month}月#{date.day}日"
  end
  
  def short_url(object)
    "http://#{request.host_with_port}/#{object.class.name.first.downcase}/#{object.id}"
  end
  
  def tag_list_for(object)
    html = '<ul class="tag_cloud">'
    html += object.tag_list.map{|tag| "  <li>#{link_to(tag,name_tags_path(:name => tag,:filter => object.class))}</li>\n"}.to_s
    html += '</ul>'
  end
  
  def tag_links_for(object)
    html = '标签： '
    html += object.tag_list[0..2].map{|tag| "#{link_to(tag,name_tags_path(:name => tag,:filter => object.class))}\n"}.to_s
    html += '...' if object.tag_list[3]
    html
  end
  
end
