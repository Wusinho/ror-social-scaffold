require 'rails_helper'

RSpec.describe 'create new user', type: :feature do
  before :each do
    @user = User.create(name: 'axel', email: 'axel@mail.com', password: '123456')
  end

  scenario 'Send Friendship request' do
    visit new_user_registration_path
    fill_in 'Name', with: 'juan'
    fill_in 'Email', with: 'juan@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    visit users_path
    click_on 'Add Friend'
    expect(page).to have_content('Pending Response')
  end

  scenario 'Accept friendship request' do
    visit new_user_registration_path
    fill_in 'Name', with: 'pepe'
    fill_in 'Email', with: 'pepe@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    visit users_path
    click_on 'Add Friend'
    expect(page).to have_content('Pending Response')

    click_on 'Sign out'
    visit user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_on 'Log in'
    click_on 'All users'
    click_on 'Accept Friendship'
    expect(page).to have_css("button")
  end
end
