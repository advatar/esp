require "micro/errors"

module CFMicro::Switcher

  class Darwin < Base
    def adminrun(command)
      CFMicro.run_command("osascript", "-e 'do shell script \"#{command}\" with administrator privileges'")
    end

    def set_nameserver(domain, ip)
      File.open("/tmp/#{domain}", 'w') { |file| file.write("nameserver #{ip}") }
      adminrun("mkdir -p /etc/resolver;mv /tmp/#{domain} /etc/resolver/")
    end

    def unset_nameserver(domain, ip)
      raise CFMicro::MCFError, "domain missing" unless domain
      adminrun("rm -f /etc/resolver/#{domain}")
    end
  end

end
