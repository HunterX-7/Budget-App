require 'rails_helper'

RSpec.describe EntitiesController, type: :request do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
  end

  context 'Entity new path tests' do
    it 'Should return a successful response' do
      get new_group_entity_path(@group)
      expect(response).to be_successful
    end

    it 'Should render the entity new page' do
      get new_group_entity_path(@group)
      expect(response).to render_template(:new)
    end

    it 'Should display the transactions in the form' do
      get new_group_entity_path(@group)
      expect(response.body).to include('TRANSACTIONS')
    end
  end
end
