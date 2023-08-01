require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  let!(:user) { User.create(name: 'Sarkodie', photo: '/path/to/photo1.jpg', post_counter: 10) }

  before do
    5.times do
      Post.create(
        title: 'Post title',
        text: 'Post text',
        author_id: user.id,
        comments_counter: 3,
        likes_counter: 7
      )
    end
    visit user_posts_path(user)
  end

  it 'displays user profile information' do
    expect(page).to have_css("img[src='#{user.photo}'][alt='user photo']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.post_counter}")
  end

  it 'displays each post with relevant information' do
    @posts = user.posts

    @posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text[0..49])
      expect(page).to have_content("Comments: #{post.comments_counter}")
      expect(page).to have_content("Likes: #{post.likes_counter}")
      expect(page).to have_link('Read post', href: user_post_path(post))
    end
  end

  it 'displays the first comments on a post' do
    @posts = user.posts

    @posts.each do |post|
      post.comments.first(2).each do |comment|
        expect(page).to have_content("#{comment.user.name} - #{comment.text}")
      end
    end
  end

  it 'Pagination' do
    expect(page).to have_button('Pagination')
  end

  it "redirects to the post's show page when clicking on the 'Read post' link" do
    @posts = user.posts

    @posts.each do |post|
      click_link 'Read post', href: user_post_path(post)
      expect(current_path).to eq(user_post_path(post))
      visit user_posts_path(user)
    end
  end
end
