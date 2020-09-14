class FacebookShareUrl < Liquid::Tag
  def initialize(tag_name, url, tokens)
     super
     @url = url
  end

  def render(context)
    "https://www.facebook.com/sharer.php?u=#{CGI.escape(@url)}"
  end
end