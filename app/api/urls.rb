class Urls < Roda
  include RequestHelper

  route do |r|
    r.get do
      paginate UrlContent.paginate(page: params[:page])
    end

    r.post do
      begin
        url_content = UrlContentService.new(params[:url]).run
      rescue UrlContentService::InvalidUrlException => e
        halt_request(422, { errors: [e.message] })
      end

      response.status = 201
      url_content
    end
  end
end
