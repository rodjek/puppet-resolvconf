require 'spec_helper'
describe 'resolvconf::nameserver', :type => :define do
 
  describe 'with a hash of domains and parameters' do
    let(:title) { '8.8.8.8' }
    let(:params) {{ :priority => '1'}}

  
    it do
    should contain_augeas('Adding nameserver 8.8.8.8 to /etc/resolv.conf').with(
      'changes' => 'set nameserver[1] 8.8.8.8'
          )
    end

  end
end
