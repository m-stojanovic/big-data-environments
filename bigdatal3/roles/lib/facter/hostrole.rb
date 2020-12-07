Facter.add(:hostroles) do
  setcode do
    case Facter.value(:fqdn)
      when /^dshdc200/ then ['base','hadoopclient','dockers','jumphost']
      when /^dshdm201/ then ['base','hadoopmaster','hadoop_kinga','hadoopmaster_kinga','resourcemanager','historyserver','flink_kinga']
      when /^dshdm202/ then ['base','hadoopmaster','hadoop_kinga','hadoopmaster_kinga','resourcemanager','historyserver','azkaban','flink_kinga']
      when /^dshdm02[0-1]/ then ['base','hadoopmaster','hadoop_hbase','hadoopmaster_hbase']
      when /^dshdp[2-3][0-9][0-9]/ then ['base','hadoopslave','hadoop_kinga','hadoopslave_kinga','nodemanager']
      when /^dshdp0[3-8][0-9]/ then ['base','hadoopslave','hadoop_hbase','hadoopslave_hbase']
      when /^dses/ then ['base','elasticsearch']
      when /^dsapi18[1-2]/ then ['base','dsapimaintainer']
      when /^dsapi18[3-4]/ then ['base','dsapi', 'schemaregistry']
      when /^dsapi185/ then ['base','dsapi','ha','kafkarest','nginx','nginx_confluentapp']
      when /^dsapi186/ then ['base','dsapi','ha','kafkarest','nginx','nginx_confluentapp','nginx_dashboard']
      when /^dsstreamm/ then ['base','resourcemanager','hadoopclient','hadoop_streaming', 'hadoopmaster_streaming','flink_streaming','historyserver']
      when /^dsstreams/ then ['base','nodemanager','hadoop_streaming', 'hadoopslave_streaming']
      when /^dsqueue/ then ['base','kafka']
      when /^dshdz/ then ['base','zookeeper_hadoop','dfsjournal']
      when /^dsapz/ then ['base','zookeeper_api']
      else 'unknown'
    end
  end
end
