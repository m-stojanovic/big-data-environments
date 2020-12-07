lookup_options:
  datastore::applications::etlservicemaintainer::templates:
    merge: deep

datastore::applications::etlservicemaintainer::templates:
  'application.properties':
    etl.server.flink.propertiesFilePath: '/flink/snapshots_27.properties'
