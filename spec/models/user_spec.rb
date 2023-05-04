require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'francisco', email: 'francisco@gmail.com', encrypted_password: '123456')
    @user.save
  end

  context 'Association tests' do
    it 'Should have user name' do
      expect(@user.name).to eq('francisco')
    end

    it 'Should have user name' do
      expect(@user.email).to eq('francisco@gmail.com')
    end

    it 'Should have many groups' do
      @user = User.reflect_on_association(:groups)
      expect(@user.macro).to eq(:has_many)
    end

    it 'Should have many entities' do
      @user = User.reflect_on_association(:entities)
      expect(@user.macro).to eq(:has_many)
    end
  end
end
