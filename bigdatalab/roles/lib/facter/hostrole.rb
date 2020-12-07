Facter.add(:hostroles) do
  setcode do
    case Facter.value(:fqdn)
      when /^hdplab20/ then ['base','hadoop','hadoopmaster','kafka','resourcemanager'] #missing - parquet-read-service, 
      when /^hdplab21/ then ['base','hadoop','hadoopmaster','kafka','resourcemanager', 'kafkamanager', 'kafkarest', 'historyserver']
      when /^hdplab22/ then ['base','hadoop','zookeeper_lab','hadoopslave','schemaregistry','dfsjournal'] 
      when /^hdplab23/ then ['base','hadoop','zookeeper_lab','hadoopslave','dfsjournal'] 
      when /^hdplab24/ then ['base','hadoop','zookeeper_lab','hadoopslave','dfsjournal']
      when /^hdplab25/ then ['base','hadoop','hadoopslave','azkaban', 'postfix'] #missing hue
      when /^hdplab2[6-7]/ then ['base','hadoop','hadoopslave','dsapimaintainer','apptest']
      when /^hdplab28/ then ['base','hadoop','hadoopslave','dsapi','apptest']
      when /^hdplab29/,/^hdplab3[0-1]/ then ['hadoop','base','hadoopslave']
      when /^hdplab33/ then ['base','hadoop','hadoopslave','flink_kinga']
      when /^hdplab34/,/^hdplab32/ then ['base','hadoop','hadoopslave','flink_streaming']

      # Unknown     
      else 'unknown'
    end
  end
end
