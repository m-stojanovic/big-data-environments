class roles::hadoopslave {
  include hadoop::roles::dfsslave
  include hbase::roles::regionserver
  include hadoop::roles::nodemanager
}