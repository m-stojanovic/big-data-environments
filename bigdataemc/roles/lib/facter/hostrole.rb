Facter.add(:hostroles) do
  setcode do
    case Facter.value(:fqdn)
      when /^dshdc1100/ then ['base','hadoopclient','dockers','jumphost','machinelearning']
      when /^dshdm1101/ then ['base','hadoopmaster','hadoop_kinga','hadoopmaster_kinga','resourcemanager','historyserver','flink_kinga']
      when /^dshdm1102/ then ['base','hadoopmaster','hadoop_kinga','hadoopmaster_kinga','resourcemanager','historyserver','azkaban','flink_kinga']
      when /^dshdm12[0-1]/ then ['base','hadoopmaster','hadoop_hbase','hadoopmaster_hbase']
      when /^dshdp11[1-9][0-9]/ then ['base','hadoopslave','hadoop_kinga','hadoopslave_kinga','nodemanager']
      when /^dshdp1[3-8][0-9]/ then ['base','hadoopslave','hadoop_hbase','hadoopslave_hbase']
      when /^dses/ then ['base','elasticsearch']
      when /^dsapi1002/ then ['base','dsapi','hadoopclient']
      when /^dsapi1003/,/^dsapi1004/ then ['base','dsapi','hadoopclient','schemaregistry']
      when /^dsapi1005/,/^dsapi1006/ then ['base','dsapimaintainer','ha','hadoopclient','kafkarest','nginx','nginx_confluentapp']
      when /^dsapi1007/ then ['base','dsapimaintainer','hadoopclient','nginx','nginx_dashboard']
      when /^dsstreamm/ then ['base','resourcemanager','hadoopclient','hadoop_streaming', 'hadoopmaster_streaming','flink_streaming','historyserver']
      when /^dsstreams/ then ['base','nodemanager','hadoop_streaming', 'hadoopslave_streaming']
      when /^dsqueue/ then ['base','kafka']
      when /^dshdz110[5-7]/ then ['base','zookeeper_hadoop','dfsjournal']
      when /^dsapz/ then ['base','zookeeper_api']
      else 'unknown'
    end
  end
end
