module RequestHelper
  def self.included(base)
    base.plugin :all_verbs
    base.plugin :indifferent_params
    base.plugin :json_parser
    base.plugin :json, classes: [Array, Hash],
      include_request: true, serializer: proc { |object, request| object.to_json }
  end
end
