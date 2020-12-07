Facter.add(:hostroles) do
  setcode do
    case Facter.value(:fqdn)
      # CROC
      when /^mp13dshdm01/ then ['base','flink_streaming','hadoopmaster']
      when /^mp13dshdm02/ then ['base','flink_kinga','hadoopmaster','historyserver']
      when /^mp13dses/ then ['base','elasticsearch']
      when /^mp13dsapi01/ then ['base','dsapimaintainer','ha', 'hadoopclient', 'kafkarest','schemaregistry']
      when /^mp13dsapi02/ then ['base','dsapi','ha', 'hadoopclient', 'kafkarest','schemaregistry','nginx']
      when /^mp13azkaban01/ then ['base','hadoopclient','azkaban']
      when /^mp13dsapz/ then ['base','zookeeper','zookeeper_api']
      when /^mp13dshdz/ then ['base','zookeeper','zookeeper_hadoop','dfsjournal']
      when /^mp13dsqueue/ then ['base','kafka']
      when /^mp13dshdp/ then ['base','hadoopslave']
      # Unknown     
      else 'unknown'
    end
  end
end
