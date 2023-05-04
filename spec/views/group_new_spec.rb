require 'rails_helper'

RSpec.describe 'groups/new', type: :feature do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
    visit new_group_path
  end

  it 'displays page header' do
    expect(page).to have_content('CATEGORIES')
  end

  it 'displays form header name' do
    expect(page).to have_content('ADD CATEGORY')
  end

  it 'displays group field name' do
    expect(page).to have_content('SELECT AN ICON')
  end

  it 'displays submit button to create' do
    expect(page).to have_button('Create')
  end
end
