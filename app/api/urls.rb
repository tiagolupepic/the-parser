class Urls < Roda
  include RequestHelper

  route do |r|
    r.get do
      []
    end

    r.post do
      response.status = 201
      []
    end
  end
end
