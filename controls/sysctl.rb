# encoding: utf-8
# author: Pascal S. Clermont


control 'sysctl-01' do
  impact 1.0
  title 'Protected sysctl'
  desc "need to make sure that the file cannot be modified."
  describe file('/etc/sysctl.conf') do
    its('mode') { should cmp '0444' }
  end
end

control 'sysctl-02' do
  impact 1.0
  title 'IPv4 Forwarding'
  desc "If you're not intending for your system to forward traffic between interfaces, or if you only have a single interface, the forwarding function must be disable."
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
  desc "If you're not intending for your system to redirecting packets, the redirect function must be disable." 
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
  desc "Disable Source Routed Packet Acceptance."
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
