module RequestHelper
  def self.included(base)
    base.plugin :all_verbs
    base.plugin :indifferent_params
    base.plugin :json_parser
    base.plugin :json, classes: [Array, Hash],
      include_request: true, serializer: proc { |object, request| object.to_json }
  end

  def halt_request(status, body)
    response.status = status
    response.write(body.to_json)
    request.halt
  end
end
