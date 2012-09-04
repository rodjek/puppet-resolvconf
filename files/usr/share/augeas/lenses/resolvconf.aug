module Resolvconf =
    autoload xfm

    let eol = Util.del_str "\n"
    let ws = Util.del_ws_spc
    let empty = Util.empty
    let comment = Util.comment
    let slash = del /\// "/"
    let colon = Util.del_str ":"
    let until_ws_or_eol = /[^\t ][^\n\t ]+/
    let until_slash_ws_or_eol = /[^\/\n\t ]+/
    let int = /[0-9]+/

    let nameserver = [ key "nameserver" . ws . store until_ws_or_eol . eol ]

    let domain = [ key "domain" . ws . store until_ws_or_eol . eol ]

    let search_domain = [ seq "search_domain" . store until_ws_or_eol ]
    let search_domain_list = search_domain . ( ws . search_domain )*
    let search = [ key "search" . ws . search_domain_list . eol ]

    let sortlist_entry = [ seq "sortlist_entry"
        . [ label "address" . store until_slash_ws_or_eol ]
        . ([ slash . label "netmask" . store until_ws_or_eol ])?
        ]
    let sortlist_list = sortlist_entry . ( ws . sortlist_entry )*
    let sortlist = [ key "sortlist" . ws . sortlist_list . eol ]

    let boolean_option (r:regexp) = [ Util.del_str "options" . ws . key r
        . eol ]
    let boolean_options = "debug" | "rotate" | "no-check-names" | "inet6"
        | "ip6-bytestring" | "ip6-dotint" | "no-ip6-dotint" | "edns0"
    let value_option (r:regexp) = [ Util.del_str "options" . ws . key r
        . colon . store int . eol ]
    let value_options = "ndots" | "timeout" | "attempts"
    let options = (value_option value_options|boolean_option boolean_options)

    let lns = (nameserver|domain|search|sortlist|options|empty|comment)*
    let xfm = transform lns (incl "/etc/resolv.conf")
