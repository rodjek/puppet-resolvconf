# Internal: Manage the Augeas lenses used by the resolvconf module.
#
# Examples
#
#   include resolvconf::lenses
class resolvconf::lenses {
  file { '/usr/share/augeas/lenses/resolvconf.aug':
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => 'puppet:///modules/resolvconf/usr/share/augeas/lenses/resolvconf.aug',
  }
}
