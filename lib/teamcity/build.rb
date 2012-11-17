class Teamcity::Build
  include ActiveAttr::Attributes
  include ActiveAttr::MassAssignment
  include ActiveAttr::TypecastedAttributes
  include ActiveAttr::AttributeDefaults

  attribute :id
  attribute :number
  attribute :status
  attribute :build_type_id
  attribute :start_date#, type: DateTime, default: ''
  attribute :href
  attribute :web_url

  attribute :project_name
  attribute :build_name

  attr_reader :client, :build_type
  protected :client, :build_type

  def initialize(client, attrs)
    attrs = Hash[attrs.map { |k, v| [k.underscore, v] }]
    super(attrs)
    @client     = client
    @build_type = client.build_type(build_type_id)
    enrich!
  end

  def enrich!
    self.project_name = build_type.project_name
    self.build_name = build_type.name
  end

  def to_json
    attributes.to_json
  end

end
