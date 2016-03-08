# puppet-resolvconf

## Usage

```puppet
# Prefer hitting a local resolver
resolvconf::nameserver { '127.0.0.1':
  priority => '0',
}

# Fallback to the network resolvers
resolvconf::nameserver { ['10.0.0.1', '10.0.0.2']: }

# Automatically add nameserver after other nameservers in the end of resolv.conf
# useful in case if some nameservers are already configured by dhclient
resolvconf::nameserver { '8.8.8.8':
  priority => 'auto',
}

# Insert nameserver on the first line of resolv.conf without overriding
# first configured one.
# May be used on GCE when installing dnsmasq as resolver/forwarder to add it
# without losing automatically configured DNS servers
resolvconf::nameserver { '127.0.0.1':
  priority => 'first',
}

# Set the resolve timeout to 1s
resolvconf::option { 'timeout':
  value => '1',
}

resolvconf::search {
  'foo.test.com':
    priority => '0';
  'bar.test.com':
    priority => '1';
  'baz.test.com':
    priority => '2';
  'test.com': ;
}
```

## Things i'd still like to fix

Having to manually specify priorities is kinda nasty.  A better approach might
be to change some of these to native types and pass values through as an array
to specify the order in a more natural way.
