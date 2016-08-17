class TheParser < Roda
  include RequestHelper

  route do |r|
    r.root do
      { name: 'The Parser Api' }
    end

    r.on 'urls' do
      r.run Urls
    end
  end
end
