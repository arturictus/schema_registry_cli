require "schema_registry_cli/version"
require 'wrappi'

module SchemaRegistryCli
  # Ruby client for confluent schema registry
  # https://github.com/confluentinc/schema-registry
  #
  class Client < Wrappi::Client
    setup do |config|
      config.domain = 'http://localhost:8081/'
      config.headers = {
        'Content-Type' => 'application/vnd.schemaregistry.v1+json'
      }
    end
  end
  
  def self.setup
    Client
  end

  class Endpoint < Wrappi::Endpoint
    client Client
  end

  def self.register(subject, schema)
    Register.new(schema: schema.to_json, subject: subject)
  end

  def self.subjects
    Subjects.new
  end

  def self.subject_versions(subject)
    SubjectVersions.new(subject: subject)
  end

  def self.fetch_schema(id)
    FetchSchema.new(id: id)
  end

  def self.fetch_version(subject, version)
    FetchVersion.new(subject: subject, version: version)
  end

  def self.latest_version(subject)
    LatestVersion.new(subject: subject)
  end

  def self.delete_version(subject, version)
    DeleteVersion.new(subject: subject, version: version)
  end

  def self.delete_subject(subject)
    DeleteSubject.new(subject: subject)
  end

  def self.check_registered(subject, body)
    CheckRegistered.new(schema: body.to_json, subject: subject)
  end

  def self.test_compatibility(subject, schema)
    TestCompatibility.new(subject: subject, schema: schema.to_json)
  end

  def self.sr_config
    SRConfig.new
  end

  def self.update_config(value)
    UpdateConfig.new(compatibility: value)
  end

  def self.update_subject_compatibility(value)
    UpdateSubjectCompatibility.new(subject: subject, compatibility: value)
  end
end

require 'schema_registry_cli/endpoints'

