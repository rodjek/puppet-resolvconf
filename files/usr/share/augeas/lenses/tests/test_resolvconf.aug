module Test_resolvconf =
    let nameserver = "nameserver 127.0.0.1\n"
    let multi_nameservers = "nameserver 127.0.0.1\nnameserver 10.0.0.1\n"

    test Resolvconf.nameserver get nameserver =
        { "nameserver" = "127.0.0.1" }

    test Resolvconf.lns get multi_nameservers =
        { "nameserver" = "127.0.0.1" }
        { "nameserver" = "10.0.0.1" }

    let domain = "domain foo.bar.test.com\n"

    test Resolvconf.domain get domain =
        { "domain" = "foo.bar.test.com" }

    let search = "search foo.bar.test.com bar.test.com test.com\n"

    test Resolvconf.search get search =
        { "search"
            { "1" = "foo.bar.test.com" }
            { "2" = "bar.test.com" }
            { "3" = "test.com" }
        }

    let sortlist = "sortlist 130.155.160.0/255.255.240.0 130.155.0.0\n"

    test Resolvconf.sortlist get sortlist =
        { "sortlist"
            { "1"
                { "address" = "130.155.160.0" }
                { "netmask" = "255.255.240.0" }
            }
            { "2"
                { "address" = "130.155.0.0" }
            }
        }

    let debug = "options debug\n"
    test Resolvconf.options get debug =
        { "options" = "debug" }

    let ndots = "options ndots:3\n"
    test Resolvconf.options get ndots =
        { "options" = "ndots"
            { "value" = "3" }
        }

    let timeout = "options timeout:5\n"
    test Resolvconf.options get timeout =
        { "options" = "timeout"
            { "value" = "5" }
        }

    let attempts = "options attempts:2\n"
    test Resolvconf.options get attempts =
        { "options" = "attempts"
            { "value" = "2" }
        }

    let rotate = "options rotate\n"
    test Resolvconf.options get rotate =
        { "options" = "rotate" }

    let no_check_names = "options no-check-names\n"
    test Resolvconf.options get no_check_names =
        { "options" = "no-check-names" }

    let inet6 = "options inet6\n"
    test Resolvconf.options get inet6 =
        { "options" = "inet6" }

    let ip6_bytestring = "options ip6-bytestring\n"
    test Resolvconf.options get ip6_bytestring =
        { "options" = "ip6-bytestring" }

    let ip6_dotint = "options ip6-dotint\n"
    test Resolvconf.options get ip6_dotint =
        { "options" = "ip6-dotint" }

    let no_ip6_dotint = "options no-ip6-dotint\n"
    test Resolvconf.options get no_ip6_dotint =
        { "options" = "no-ip6-dotint" }

    let edns0 = "options edns0\n"
    test Resolvconf.options get edns0 =
        { "options" = "edns0" }

    let whole_file = "# some comment\n"
        . "; another way of comments\n"
        . "nameserver 127.0.0.1\n"
        . "nameserver 10.0.0.1\n"
        . "\n"
        . "search foo.test.com test.com\n"
        . "sortlist 127.0.0.1/255.0.0.0 10.0.0.0\n"
        . "domain foo.test.com\n"
        . "options debug\n"
        . "options timeout:1\n"

    test Resolvconf.lns get whole_file =
        { "#comment" = "some comment" }
        { "#comment" = "another way of comments" }
        { "nameserver" = "127.0.0.1" }
        { "nameserver" = "10.0.0.1" }
        {  }
        { "search"
            { "1" = "foo.test.com" }
            { "2" = "test.com" }
        }
        { "sortlist"
            { "1"
                { "address" = "127.0.0.1" }
                { "netmask" = "255.0.0.0" }
            }
            { "2"
                { "address" = "10.0.0.0" }
            }
        }
        { "domain" = "foo.test.com" }
        { "options" = "debug" }
        { "options" = "timeout"
            { "value" = "1" }
        }
