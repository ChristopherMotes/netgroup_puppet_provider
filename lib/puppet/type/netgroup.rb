require 'puppet/property/ordered_list'

module Puppet
  newtype(:netgroup) do
    ensurable

    newproperty(:target) do
      desc "The file in which to store service information.  Only used by
        those providers that write to disk. On most systems this defaults to `/etc/passwd`."

      defaultto { if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
        @resource.class.defaultprovider.default_target
        else
          nil
        end
      }
    end

    newparam(:name) do
      desc "The netgroup name."

      isnamevar

      validate do |value|
       if value =~ /^\+(\@)?\w.*$/
            raise Puppet::Error, "%s Invalid netgroup name. Do NOT use +@" % value
        end
      end
      munge do |value|
        value = '+@' + value
      end
    end

    @doc = "Installs and manages passwd entries for netroups.  For most systems, these
      entries will just be in `/etc/passwd'."
  end
end
