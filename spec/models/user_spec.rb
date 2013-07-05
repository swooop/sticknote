require 'spec_helper'

describe User do
  subject( :user ) { create( :user ) }

  it "has a valid factory" do
    expect( create( :user ) ).to be_valid
  end

  it "is invalid without a username" do
    expect( build( :user, username: nil ) ).not_to be_valid
  end

  it "is invalid without an email" do
    expect( build( :user, email: nil ) ).not_to be_valid
  end


  # describe '.new' do
  #   it 'creates a new User instance' do
  #     user = User.new
  #     expect(user).to be_an_instance_of(User)
  #   end
  # end

  # describe '.create' do
  #   it 'has an id' do
  #     user = User.create()
  #     expect(user).to_not eq nil
  #   end

  # end
end