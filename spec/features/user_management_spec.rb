require 'spec_helper'

feature "User visits homepage" do

  scenario "while being signed in" do
    visit '/'
    expect(page).to have_content("Welcome to Rwitter")
  end
end


feature "User signs in" do

  before(:each) do
    User.create(:fullname => 'richard ighodaro',
    :username => 'iggyster3',
    :email => 'test@test.com',
    :password => 'test',
    :password_confirmation => 'test')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, richard ighodaro")
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome, richard ighodaro")
  end

  # scenario "with incorrect credentials" do
  #   visit '/'
  #   expect(page).not_to have_content("Welcome, test@test.com")
  #   sign_in('test@test.com', 'wrong')
  #   expect(page).not_to have_content("Welcome, test@test.com")
  # end

  def sign_in(email, password)
    visit '/user/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end
