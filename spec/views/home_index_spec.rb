require 'rails_helper'

RSpec.describe 'home/index', type: :feature do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
    visit root_path
  end

  it 'displays App name' do
    expect(page).to have_content('BudgetApp')
  end

  it 'displays user name' do
    expect(page).to have_content(@user.name)
  end

  it 'displays sign in as' do
    expect(page).to have_content('Signed in as')
  end

  it 'displays a sign out button' do
    expect(page).to have_content('Sign out')
  end
end
