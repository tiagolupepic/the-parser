class TheParser < Roda
  include RequestHelper

  route do |r|
    r.root do
      { name: 'The Parser Api' }
    end
  end
end
