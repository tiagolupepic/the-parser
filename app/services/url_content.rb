class UrlContentService
  attr_reader :url

  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  def initialize(url)
    @url = url
  end

  def run
    return unless valid_url?
    create_url_with_content
  end

  private

  def create_url_with_content
    UrlContent.create! params
  end

  def document
    @document ||= open(url)
  end

  def page
    @page ||= Nokogiri::HTML(document)
  end

  def params
    {
      name:          document.base_uri.to_s,
      headers_one:   cleanup_empty(page.css('h1').map(&:text)),
      headers_two:   cleanup_empty(page.css('h2').map(&:text)),
      headers_three: cleanup_empty(page.css('h3').map(&:text)),
      links:         page_links
    }
  end

  def page_links
    page.css('a').collect   { |link| link.attributes['href'].try(:value) }
                 .delete_if { |value| not value =~ VALID_URL_REGEX }
  end

  def cleanup_empty(content)
    content.map(&:squish)
  end

  def valid_url?
    url =~ VALID_URL_REGEX
  end
end
