require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:users) do
    [
      User.create(name: 'Sarkodie', photo: '/path/to/photo1.jpg', post_counter: 10),
      User.create(name: 'Ponobiom', photo: '/path/to/photo2.jpg', post_counter: 5),
      User.create(name: 'Stonebwoy', photo: '/path/to/photo3.jpg', post_counter: 3)
    ]
  end

  before do
    visit root_path
  end

  it 'displays the username of all other users' do
    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays the profile picture for each user' do
    users.each do |user|
      expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
    end
  end

  it 'displays the number of posts each user has written' do
    users.each do |user|
      expect(page).to have_content("Number of posts: #{user.post_counter}")
    end
  end

  it "redirects to the correct user's show page when clicking on a user's profile link" do
    users.each do |user|
      click_link 'View profile', href: user_path(user)
      expect(page).to have_current_path(user_path(user))
      visit root_path
      expect(page).to have_link('View profile', href: user_path(user.id))
    end
  end
end
