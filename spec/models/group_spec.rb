require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', encrypted_password: '123456')
    @group = Group.new(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.new(user: @user, name: 'Electricity', amount: 350)
  end

  context 'Validation tests' do
    it 'Validation should be successful' do
      expect(@group).to be_valid
    end

    it 'Group should have a name' do
      expect(@group.name).to be_present
    end

    it 'Group should have an icon' do
      expect(@group.icon).to be_present
    end

    it 'Group name should be string' do
      expect(@group.name).to be_a_kind_of(String)
    end

    it 'Group icon should be string' do
      expect(@group.icon).to be_a_kind_of(String)
    end

    it 'Group should have a user' do
      expect(@group.user).to be_present
    end
  end

  context 'Association tests' do
    it 'Group should belong to a user' do
      @group = Group.reflect_on_association(:user)
      expect(@group.macro).to eq(:belongs_to)
    end

    it 'Group should have many and belongs to many entities' do
      @group = Group.reflect_on_association(:entities)
      expect(@group.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
