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
    Register.call!(schema: schema.to_json, subject: subject).body
  end

  def self.subjects
    Subjects.call!.body
  end

  def self.subject_versions(subject)
    SubjectVersions.call!(subject: subject).body
  end

  def self.fetch_schema(id)
    FetchSchema.call!(id: id).body
  end
  def self.fetch(id)
    fetch_schema(id)
  end

  def self.fetch_version(subject, version = "latest")
    FetchVersion.call!(subject: subject, version: version).body
  end
  def self.subject_version(*args)
    fetch_version(*args)
  end

  def self.latest_version(subject)
    LatestVersion.call!(subject: subject).body
  end

  def self.delete_version(subject, version)
    DeleteVersion.call!(subject: subject, version: version).body
  end

  def self.delete_subject(subject)
    DeleteSubject.call!(subject: subject).body
  end

  def self.check_registered(subject, body)
    CheckRegistered.call!(schema: body.to_json, subject: subject).body
  end

  def self.test_compatibility(subject, schema)
    TestCompatibility.call!(subject: subject, schema: schema.to_json).body
  end

  def self.sr_config
    SRConfig.call!.body
  end

  def self.update_config(value)
    UpdateConfig.call!(compatibility: value).body
  end

  def self.update_subject_compatibility(value)
    UpdateSubjectCompatibility.call!(subject: subject, compatibility: value).body
  end
end

require 'schema_registry_cli/endpoints'

