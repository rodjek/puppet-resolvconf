require 'spec_helper'
describe 'resolvconf::search', :type => :define do
 
  describe 'with a hash of domains and parameters' do
    let(:title) { 'test.domain.com' }
    let(:params) {{ :priority => '1'}}

  
    it do
    should contain_augeas("Adding search domain 'test.domain.com' to /etc/resolv.conf").with(
      'changes' => "set search/domain[1] 'test.domain.com'"
          )
    end

  end
end
