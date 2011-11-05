class shorewall::rules::munin(
  $munin_port = hiera('munin_port','4949'),
  $munin_collector = hiera('munin_collector','127.0.0.1'),
  $collector_interface_source = hiera('munin_collector_interface_source','net')
){
    shorewall::params { 'MUNINPORT': value => $munin_port }
    shorewall::params { 'MUNINCOLLECTOR': value => $munin_collector }
    shorewall::rule{'net-me-munin-tcp':
        source          => "${collector_interface_source}:\$MUNINCOLLECTOR",
        destination     => '$FW',
        proto           => 'tcp',
        destinationport => '$MUNINPORT',
        order           => 240,
        action          => 'ACCEPT';
    }
}
