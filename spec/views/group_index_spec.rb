require 'rails_helper'

RSpec.describe 'groups/index', type: :feature do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
    visit groups_path
  end

  it 'displays page header' do
    expect(page).to have_content('CATEGORIES')
  end

  it 'displays group name' do
    expect(page).to have_content(@group.name)
  end

  it 'displays group creation date' do
    expect(page).to have_content(@group.updated_at.strftime('%d %b %Y'))
  end

  it 'displays link to add category' do
    expect(page).to have_link('ADD CATEGORY', href: new_group_path)
  end
end
