FactoryGirl.define do
  factory :url_content do
    name          'http://www.google.com'
    headers_one   ['This is one header', 'Second h1 tag']
    headers_two   ['Header h2', 'Second h2 tag']
    headers_three ['Another h3 header']
    links         ['http://www.bing.com']
  end
end
