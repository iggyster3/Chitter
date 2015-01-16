require 'spec_helper'

feature "User signs in" do

  scenario "while being signed in" do
    visit '/'
    expect(page).to have_content("Welcome to Rwitter")
  end
end
