class UrlContentService
  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  attr_reader :url

  class InvalidUrlException < Exception; end

  def initialize(url)
    @url = url
  end

  def run
    return invalid_url unless valid_url?(url)
    create_url_with_content
  end

  private

  def create_url_with_content
    UrlContent.create! params
  end

  def document
    @document ||= open(url, :allow_redirections => :all)
  end

  def page
    @page ||= Nokogiri::HTML(document)
  end

  def params
    {
      name:          document.base_uri.to_s,
      headers_one:   text_content_from('h1'),
      headers_two:   text_content_from('h2'),
      headers_three: text_content_from('h3'),
      links:         page_links
    }
  end

  def page_links
    page.css('a').collect   { |link| link.attributes['href'].try(:value) }
                 .delete_if { |value| !valid_url?(value) }
  end

  def valid_url?(url)
    url =~ VALID_URL_REGEX
  end

  def text_content_from(tag_name)
    page.css(tag_name)
        .map(&:text)
        .map(&:squish)
  end

  def invalid_url
    raise InvalidUrlException, 'This is not valid URL.'
  end
end
