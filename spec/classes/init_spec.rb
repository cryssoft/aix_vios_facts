require 'spec_helper'
describe 'aix_vios_facts' do
  context 'with default values for all parameters' do
    it { should contain_class('aix_vios_facts') }
  end
end
