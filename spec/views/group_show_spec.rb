require 'rails_helper'

RSpec.describe 'groups/show', type: :feature do
  include Warden::Test::Helpers

  before do
    @user = User.create(name: 'francisco', email: 'francisco@gmail.com', password: '123456',
                        password_confirmation: '123456')
    @user.skip_confirmation!
    @user.save
    login_as(@user, scope: :user)
    @group = Group.create(name: 'Utilities', icon: 'icon1.png', user: @user)
    @entity = Entity.create(user: @user, name: 'Electricity', amount: 350)
    visit group_path(@group)
  end

  it 'displays page header' do
    expect(page).to have_content('TRANSACTIONS')
  end

  it 'displays group name' do
    expect(page).to have_content(@group.name)
  end

  it 'displays group total' do
    expect(page).to have_content(@group.entities.sum(:amount))
  end

  it 'displays a list of icons' do
    expect(page).to have_link('ADD A TRANSACTION', href: new_group_entity_path(@group))
  end
end
