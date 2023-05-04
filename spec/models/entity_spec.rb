require 'rails_helper'

RSpec.describe Entity, type: :model do
  before(:each) do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', encrypted_password: '123456')
    @group = Group.new(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.new(user: @user, name: 'Electricity', amount: 350)
  end

  context 'Validation tests' do
    it 'Validation should be successful' do
      expect(@entity).to be_valid
    end

    it 'Entity should have a name' do
      expect(@entity.name).to be_present
    end

    it 'Entity should have an amount' do
      expect(@entity.amount).to be_present
    end

    it 'Entity name should be string' do
      expect(@entity.name).to be_a_kind_of(String)
    end

    it 'Entity amount should be numeric' do
      expect(@entity.amount).to be_a_kind_of(Numeric)
    end

    it 'Entity should have a user' do
      expect(@entity.user).to be_present
    end
  end

  context 'Association tests' do
    it 'Entity should belong to a user' do
      @entity = Entity.reflect_on_association(:user)
      expect(@entity.macro).to eq(:belongs_to)
    end

    it 'Entity should have many and belongs to many groups' do
      @entity = Entity.reflect_on_association(:groups)
      expect(@entity.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
