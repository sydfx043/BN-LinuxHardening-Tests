# encoding: utf-8
# author: Pascal S. Clermont

control 'os-01' do
  title 'Daemon UMASK'
  desc "daemon's umask should be set to 027"
  describe file('/etc/sysconfig/init') do
    its('content') { should match %r{.*\numask\s+027[^0-9].*} }
  end
end

control 'os-02' do
  title 'user UMASK'
  desc "verify default umask for users to 077"
  describe file('/etc/profile.d/umask.sh') do
    its('content') { should match %r{umask\s+077} }
  end
  describe file('/etc/bashrc') do
    its('content') { should match %r{.*\n\s*umask\s+077[^0-9].*} }
  end
end

control 'os-03' do
  title 'Login Banner'
  desc "verify login banner does not contain sensitive information."
  describe file('/etc/motd') do
    its('content') { should_not match %r{.*\\[mrsv].*} }
  end
  describe file('/etc/issue') do
    its('content') { should_not match %r{.*\\[mrsv].*} }
  end
  describe file('/etc/issue.net') do
    its('content') { should_not match %r{.*\\[mrsv].*} }
  end
end

control 'os-04' do
  title 'Password Duration'
  desc "Password should be valid for atleast 1 day"
  describe login_defs do
    its('PASS_MIN_DAYS') { should eq '1' }
    its('PASS_MAX_DAYS') { should eq '90' }
  end
end

control 'os-05' do
  title 'SU reserved to wheel group'
  desc "only a memeber of the wheel group should be able to use SU."
  describe file('/etc/pam.d/su') do
    its('content') { should match(%r{.*\nauth\s+required\s+pam_wheel.so\s+use_uid\s*\n.*}) }
  end
end

control 'os-06' do
  title 'Limit password reuse'
  desc "Password should not be reused to 4"
  describe file('/etc/pam.d/system-auth') do
    its('content') { should match(%r{.*\npassword\s+sufficient\s+pam_unix.so.*remember=4.*\n.*}) }
  end
end

control 'os-07' do
  title 'Password Compliant'
  desc "Define pam_pwquality to be compliant with the bank requirement"
  describe file('/etc/pam.d/passwd') do
    its('content') { should match(%r{.*\npassword\s+required\s+pam_pwquality.so\s+try_first_pass\s+retry=5.*}) }
  end
  describe parse_config_file('/etc/security/pwquality.conf') do
    its('minlen') { should eq '8' }
    its('dcredit') { should eq '1' }
    its('ucredit') { should eq '1' }
    its('ocredit') { should eq '1' }
    its('lcredit') { should eq '1' }
    its('minclass') { should eq '4' }
  end
end

