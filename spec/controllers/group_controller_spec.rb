require 'rails_helper'

RSpec.describe GroupsController, type: :request do
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

  context 'Group index path tests' do
    it 'Should return a successful response' do
      get '/groups'
      expect(response).to be_successful
    end

    it 'Should render the group index page' do
      get '/groups'
      expect(response).to render_template(:index)
    end

    it 'Should display the categories in the navbar' do
      get '/groups'
      expect(response.body).to include('CATEGORIES')
    end
  end

  context 'Group show path tests' do
    it 'Should return a successful response' do
      get group_path(id: @group)
      expect(response).to be_successful
    end

    it 'Should render the group show page' do
      get group_path(id: @group)
      expect(response).to render_template(:show)
    end

    it 'Should display the transactions in the navbar' do
      get group_path(id: @group)
      expect(response.body).to include('TRANSACTIONS')
    end
  end

  context 'Group new path tests' do
    it 'Should return a successful response' do
      get new_group_path
      expect(response).to be_successful
    end

    it 'Should render the group new page' do
      get new_group_path
      expect(response).to render_template(:new)
    end

    it 'Should display the transactions in the form title' do
      get new_group_path
      expect(response.body).to include('ADD CATEGORY')
    end
  end
end
