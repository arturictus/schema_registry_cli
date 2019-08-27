# SchemaRegistryCli

Ruby Client for Confluent Schema registry (https://github.com/confluentinc/schema-registry)[https://github.com/confluentinc/schema-registry]

This gem is builded with (wrappi)[https://github.com/arturictus/wrappi] you can check more documentation of how to use it there.

## TODO

- [ ] Add cache

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schema_registry_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schema_registry_cli

## Config

Setup is a `Wrappi::Client` check more documentation at:

- (table of configs)[https://github.com/arturictus/wrappi#client]
- (extended docs)[https://github.com/arturictus/wrappi#client-1]

```ruby
SchemaRegistryCli.setup do |config|
  config.domain = "http://my-registry.com:8081"
end
```

## Usage

### Helpers

```ruby
SchemaRegistryCli.register('kafka-key', 'string')# => {"id":1}
SchemaRegistryCli.lastest_version('not-registered') # => ERROR
```

___methods:___

- register(subject, schema)
- subjects
- subject_versions(subject)
- fetch_schema(id)
- fetch_version(subject, version)
- latest_version(subject)
- delete_version(subject, version)
- delete_subject(subject)
- check_registered(subject, schema)
- test_compatibility(subject, schema)
- sr_config
- update_config(value)
- update_subject_compatibility(value)

### Internal Classes

You can use the internal classes. They are `Wrappi::Endpoint`s. (wrappi)[https://github.com/arturictus/wrappi#usage]
Declarations and ruby docs (here)[lib/schema_registry_cli/endpoints.rb]

```ruby
req = SchemaRegistryCli::Register.new(subject: "kafka-key", schema: "{\"type\": \"string\"}")
req.body #=> {"id":1}
```

classes available:

- Register
- Subjects
- SubjectVersions
- FetchSchema
- FetchVersion
- LatestVersion
- DeleteVersion
- DeleteSubject
- CheckRegistered
- TestCompatibility
- SRConfig
- UpdateConfig
- UpdateSubjectCompatibility


### Rake

```
rake -T

rake schema_registry_cli:delete_all_schemas  # [DESTRUCTIVE] this will delete all schemas
rake schema_registry_cli:show_latest         # show last version of all registered schemas
```

## Development

run schema registry locally:

```
bin/run_registry
```

run tests:

```
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arturictus/schema_registry_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the SchemaRegistryCli project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arturictus/schema_registry_cli/blob/master/CODE_OF_CONDUCT.md).
