require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let!(:user) { User.create(name: 'Sarkodie', photo: '/path/to/photo1.jpg', post_counter: 10) }

  before do
    5.times do
      Post.create(
        title: 'Post title',
        text: 'Post text',
        author_id: user.id
      )
    end
    visit user_path(user)
  end

  it 'User profile information' do
    expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.post_counter}")
    expect(page).to have_content(user.bio)
  end

  it 'Displaying first 3 posts' do
    user.posts.order(created_at: :desc).limit(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'View all posts button redirects to user posts index page' do
    expect(page).to have_button('See all posts')
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user))
  end

  it "Redirects to the post's show page when clicking on a user's post" do
    posts = user.posts
    posts.each do |post|
      click_link post.title
      expect(current_path).to eq(post_path(post))
      visit user_path(user)
    end
  end
end
