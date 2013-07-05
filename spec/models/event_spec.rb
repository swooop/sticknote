require 'spec_helper'

describe Event do
  subject( :event ) { create( :event ) }

  it 'has a valid factory' do
    expect( create( :event ) ).to be_valid
  end

  it 'invalid without a name' do
    expect( build( :event, name: nil ) ).not_to be_valid
  end

  it 'invalid without a description' do
    expect( build( :event, description: nil ) ).not_to be_valid
  end

  it 'invalid without a link' do
    expect( build( :event, link: nil ) ).not_to be_valid
  end
end