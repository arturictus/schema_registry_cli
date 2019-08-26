module SchemaRegistryCli
  class Register < Endpoint
    # Register a new version of a schema under the subject "Kafka-key"
    # example:
    #     req = Register.new(subject: "kafka-key", schema: "{\"type\": \"string\"}")
    #     req.body #=> {"id":1}
    path "subjects/:subject/versions"
    verb :post
  end

  
  class Subjects < Endpoint
    # List all subjects
    # example:
    #     req = Subjects.new
    #     req.body #=> ["Kafka-value","Kafka-key"]
    path "subjects"
  end
  
  
  class SubjectVersions < Endpoint
    # List all schema versions registered under the subject "kafka-key"
    # example:
    #     req = SubjectVersions.new(subject: "kafka-key")
    #     req.body #=> [1]
    path 'subjects/:subject/versions'
  end
  
  
  class FetchSchema < Endpoint
    # Fetch a schema by globally unique id
    # example:
    #    req = FetchSchema.new(id: 1)
    #    req.body
    #    #=> {"schema":"\"string\""}
    path 'schemas/ids/:id'
  end
  
  
  class FetchVersion < Endpoint
    # Fetch version 1 of the schema registered under subject "Kafka-value"
    # example:
    #    req = FetchVersion.new(subject: "kafka-value", version: 1)
    #    req.body
    #    #=> {"subject":"Kafka-value","version":1,"id":1,"schema":"\"string\""}
    path 'subjects/:subject/versions/:version'
  end
  
  
  class LatestVersion < Endpoint
    # Fetch the most recently registered schema under subject "Kafka-value"
    # example:
    #     req = LatestVersion.new(subject: "kafka-value")
    #     req.body 
    #     #=> {"subject":"Kafka-value","version":1,"id":1,"schema":"\"string\""}
    path 'subjects/:subject/versions/latest'
  end
  
  
  class DeleteVersion < Endpoint
    # Delete version 3 of the schema registered under subject "Kafka-value"
    # example:
    #     req = DeleteVersion.new(subject: "Kafka-value", version: 3)
    #     req.body #=> 3
    path 'subjects/:subject/versions/:version'
    verb :delete
  end
  
  
  class DeleteSubject < Endpoint
    # Delete all versions of the schema registered under subject "Kafka-value"
    # example:
    #    req = DeleteSubject.new(subject: "Kafka-value")
    #    req.body #=> [1, 2, 3, 4, 5]
    path 'subjects/:subject'
    verb :delete
  end
  
  
  class CheckRegistered < Endpoint
    # Check whether a schema has been registered under subject "Kafka-key"
    # example:
    #    req = CheckRegistered.new(subject: "Kafka-key", schema: "{\"type\": \"string\"}")
    #    req.body
    #    #=> {"subject":"Kafka-key","version":1,"id":1,"schema":"\"string\""}
    path 'subjects/:subject'
    verb :post
  end
  
  
  class TestCompatibility < Endpoint
    # Test compatibility of a schema with the latest schema under subject "Kafka-value"
    # example:
    #    req = TestCompatibility.new(subject: "Kafka-value", schema: "{\"type\": \"string\"}")
    #    req.body #=> {"is_compatible":true}
    path "compatibility/subjects/:subject/versions/latest"
    verb :post
  end
  
  class SRConfig < Endpoint
    # Get top level config
    # example:
    #     req = SRConfig.new
    #     req.body #=> {"compatibilityLevel":"BACKWARD"}
    path 'config'
  end
  
  
  class UpdateConfig < Endpoint
    # Update compatibility requirements globally
    # example:
    #     req = UpdateConfig.new(compatibility: "NONE")
    #     req.body #=> {"compatibility":"NONE"}
    path 'config'
    verb :put
  end
  
  class UpdateSubjectCompatibility < Endpoint
    # Update compatibility requirements under the subject "Kafka-value"
    # example:
    #     req = UpdateSubjectCompatibility.new(subject: "Kafka-value", compatibility: "BACKWARD")
    #     req.body #=> {"compatibility":"BACKWARD"}
    path 'config/:subject'
    verb :put
  end
  

end
