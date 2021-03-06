# encoding: utf-8
# author: Pascal S. Clermont


control 'sysctl-01' do
  impact 1.0
  title 'Protected sysctl'
  desc 'need to make sure that the file cannot be modified.'
  describe file('/etc/sysctl.conf') do
    its('mode') { should cmp '0444' }
  end
end

control 'sysctl-02' do
  impact 1.0
  title 'IPv4 Forwarding'
  desc 'If you are not intending for your system to forward traffic between interfaces, or if you only have a single interface, the forwarding function must be disable.'
  describe kernel_parameter('net.ipv4.ip_forward') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.ip_forward.*0})  }
  end
end

control 'sysctl-03' do
  impact 1.0
  title 'Packet Redirects'
  desc 'If you are not intending for your system to redirecting packets, the redirect function must be disable.'
  describe kernel_parameter('net.ipv4.conf.all.send_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.send_redirects.*0})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.send_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.send_redirects.*0})  }
  end
end

control 'sysctl-04' do
  impact 1.0
  title 'Source routed packets'
  desc 'Disable Source Routed Packet Acceptance.'
  describe kernel_parameter('net.ipv4.conf.all.accept_source_route') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.accept_source_route.*0})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.accept_source_route') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.accept_source_route.*0})  }
  end
end

control 'sysctl-05' do
  impact 1.0
  title 'ICMP Redirect'
  desc 'Disable ICMP Redirect Acceptance.'
  describe kernel_parameter('net.ipv4.conf.all.accept_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.accept_redirects.*0})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.accept_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.accept_redirects.*0})  }
  end
end

control 'sysctl-06' do
  impact 1.0
  title 'Secure ICMP Redirect'
  desc 'Disable Secure ICMP Redirect Acceptance.'
  describe kernel_parameter('net.ipv4.conf.all.secure_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.secure_redirects.*0})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.secure_redirects') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.secure_redirects.*0})  }
  end
end

control 'sysctl-07' do
  impact 1.0
  title 'Bad Error Message Protection'
  desc 'Enable Bad Error Message Protection'
  describe kernel_parameter('net.ipv4.icmp_ignore_bogus_error_responses') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.icmp_ignore_bogus_error_responses.*1})  }
  end
end

control 'sysctl-08' do
  impact 1.0
  title 'TCP SYN cookies'
  desc 'Enable TCP SYN cookies'
  describe kernel_parameter('net.ipv4.tcp_syncookies') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.tcp_syncookies.*1})  }
  end
end

control 'sysctl-09' do
  impact 1.0
  title 'Source Route Validation'
  desc 'Enable RFC-recommended Source Route Validation.'
  describe kernel_parameter('net.ipv4.conf.all.rp_filter') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.rp_filter.*1})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.rp_filter') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.rp_filter.*1})  }
  end
end

control 'sysctl-10' do
  impact 1.0
  title 'Ignore Broadcast Requests'
  desc 'Enable Ignore Broadcast Requests.'
  describe kernel_parameter('net.ipv4.icmp_echo_ignore_broadcasts') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.icmp_echo_ignore_broadcasts.*1})  }
  end
end

control 'sysctl-11' do
  impact 1.0
  title 'Log Suspicious Packets'
  desc 'Enable Log Suspicious Packets'
  describe kernel_parameter('net.ipv4.conf.all.log_martians') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.all.log_martians.*1})  }
  end
  describe kernel_parameter('net.ipv4.conf.default.log_martians') do
    its(:value) { should eq 1 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{net.ipv4.conf.default.log_martians.*1})  }
  end
end

control 'sysctl-12' do
  impact 1.0
  title 'Core Dumps'
  desc 'Restrict Core Dumps'
  describe kernel_parameter('fs.suid_dumpable') do
    its(:value) { should eq 0 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{fs.suid_dumpable.*0})  }
  end
end

control 'sysctl-13' do
  impact 1.0
  title 'Virtual Memory Placement'
  desc 'Enable Randomized Virtual Memory Region Placement.'
  describe kernel_parameter('kernel.randomize_va_space') do
    its(:value) { should eq 2 }
  end
  describe file('/etc/sysctl.conf') do
    its('content') { should match(%r{kernel.randomize_va_space.*2})  }
  end
end
