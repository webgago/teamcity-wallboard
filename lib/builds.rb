require "active_support/core_ext"

class Builds
  attr_reader :client, :build_types
  protected :client, :build_types

  def initialize(client)
    @client = client
  end

  def build_types
    client.build_types.map { |type| type['id'] }
  end

  def running
    builds = client.build({ }, { locator: 'running:true' })['build']
    Array(builds).map do |b|
      {
          'type'       => b['buildTypeId'],
          'running'    => b['running'],
          'number'     => b['number'],
          'percentage' => b['percentageComplete'],
          'status'     => status(b),
          'start_date'  => start_date(b)
      }
    end
  end

  def latest
    builds = build_types.map { |build_type| client.build(buildType: build_type) }.compact
    Array(builds).map do |build|
      {
          'id'          => id(build),
          'type'        => type(build),
          'name'        => name(build),
          'status'      => status(build),
          'commiters'   => commiters(build),
          'status_text' => status_text(build),
          'start_date'  => start_date(build)
      }
    end
  end

  protected

  def id(build)
    build['id']
  end

  def type(build)
    build['buildType']['id']
  end

  def name(build)
    [build['buildType']['projectName'], build['buildType']['name']].join(' ')
  end

  def status(build)
    build['status'].downcase
  end

  def status_text(build)
    build['statusText']
  end

  def start_date(build)
    build['startDate'].to_datetime.getutc.iso8601
  end

  def commiters(build)
    client.commiters(build['changes']['href'])
  end
end

