require 'spec_helper'

describe 'packages' do
  it do
    should contain_package('ack')
    should contain_package('mtr')
    should contain_package('airmail-beta')
  end
end
