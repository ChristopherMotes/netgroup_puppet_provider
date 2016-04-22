require 'puppet/provider/parsedfile'
netgroup = "/etc/passwd"

Puppet::Type.type(:netgroup).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => netgroup, :filetype => :flat) do

    desc "The netgroup provider that uses the ParsedFile class"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    record_line :parsed, :fields => %w{name}
end
