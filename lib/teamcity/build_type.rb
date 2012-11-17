class Teamcity::BuildType
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment

  attr_reader :client
  protected :client

  attribute :name
  attribute :project_name

  def initialize(client, id)
    @client = client

    attrs = JSON.parse(client["buildTypes/#{id}"].get accept: :json)
    attrs = Hash[attrs.map { |k, v| [k.underscore, v] }]

    attrs['project_name'] = attrs['project']['name']
    super(attrs)
  end

end
