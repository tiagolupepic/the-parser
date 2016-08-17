class UrlContentService
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def run
    return if url.blank?
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
      name:          url,
      headers_one:   page.css('h1').map(&:text),
      headers_two:   page.css('h2').map(&:text),
      headers_three: page.css('h3').map(&:text),
      links:         page_links
    }
  end

  def page_links
    page.css('a').collect { |link| link.attributes['href'].value }
  end
end
