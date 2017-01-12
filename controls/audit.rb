# encoding: utf-8
# author: Pascal S. Clermont


control 'audit-01' do
  title 'Audit configuration Immutable'
  desc 'the Audit Configuration should be Immutable'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-e 2}) }
  end
end

control 'audit-02' do
  title 'Audit Date / time'
  desc 'the Audit Configuration should Record Events That Modify Date and Time Information'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S clock_settime -k time-change}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S clock_settime -k time-change}) }
    its('lines') { should contain_match(%r{-w /etc/localtime -p wa -k time-change}) }
  end
end

control 'audit-03' do
  title 'Audit network'
  desc 'the Audit Configuration should Record Events That Modify System\'s Network Environment'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale}) }
    its('lines') { should contain_match(%r{-w /etc/issue -p wa -k system-locale}) }
    its('lines') { should contain_match(%r{-w /etc/issue.net -p wa -k system-locale}) }
    its('lines') { should contain_match(%r{-w /etc/hosts -p wa -k system-locale}) }
    its('lines') { should contain_match(%r{-w /etc/sysconfig/network -p wa -k system-locale}) }
  end
end

control 'audit-04' do
  title 'Audit user/group'
  desc 'the Audit Configuration should Record Events That Modify User/Group Information'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-w /etc/group -p wa -k identity}) }
    its('lines') { should contain_match(%r{-w /etc/passwd -p wa -k identity}) }
    its('lines') { should contain_match(%r{-w /etc/gshadow -p wa -k identity -w /etc/shadow -p wa -k identity}) }
    its('lines') { should contain_match(%r{-w /etc/security/opasswd -p wa -k identity}) }
  end
end

control 'audit-05' do
  title 'Audit session'
  desc 'the Audit Configuration should Collect Session Initiation Information'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-w /var/run/utmp -p wa -k session}) }
    its('lines') { should contain_match(%r{-w /var/log/wtmp -p wa -k session}) }
    its('lines') { should contain_match(%r{-w /var/log/btmp -p wa -k session}) }
  end
end

control 'audit-06' do
  title 'Audit acl'
  desc 'the Audit Configuration should Collect Discretionary Access Control Permission Modification Events'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
  end
end

control 'audit-07' do
  title 'Audit fileperm'
  desc 'the Audit Configuration should Collect Unsuccessful Unauthorized Access Attempts to Files'
  describe auditd_rules do
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
    its('lines') { should contain_match(%r{-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod}) }
  end
end
