require 'spec_helper'

feature "User visits homepage" do

  scenario "while being signed in" do
    visit '/'
    expect(page).to have_content("Welcome to Rwitter")
  end
end


feature "User signs up" do

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
    sign_up('iggyster3', 'test')
    expect(page).to have_content("Welcome,")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, richard ighodaro")
    sign_in('iggyster3', 'wrong')
    expect(page).not_to have_content("Welcome, richard ighodaro")
  end

  scenario "with a password that doesn't match" do
    expect{ sign_up('iggy', 'pass', 'wrong@test.com', 'pass', 'passss') }.to change(User, :count).by(0)
    expect(current_path).to eq('/')
    expect(page).to have_content("Password does not match the confirmation")
  end

  def sign_up(fullname = "Richie",
    username = "iggyster123",
    email = "test2@test.com ",
    password = "shardae3",
    password_confirmation = "shardae3")
    visit '/'
    fill_in :fullname, :with => fullname
    fill_in :username, :with => username
    fill_in :email,    :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign in"
  end

  def sign_in(username, password)
    visit '/'
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end
