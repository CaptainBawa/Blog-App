require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  let!(:user) { User.create(name: 'Sarkodie', photo: '/path/to/photo1.jpg', post_counter: 10) }
  let!(:post) do
    Post.create(
      title: 'Test Post',
      text: 'This is a test post.',
      author_id: user.id,
      comments_counter: 3,
      likes_counter: 7
    )
  end

  describe 'GET #show' do
    before { visit user_post_path(post) }

    it 'displays the post title' do
      expect(page).to have_content(post.title)
    end

    it 'displays the number of comments' do
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end

    it 'displays the number of likes' do
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end

    it 'displays the post body' do
      expect(page).to have_content(post.text)
    end

    it 'displays the username of each commenter and their comment' do
      post.comments.each do |comment|
        expect(page).to have_content("#{comment.user.name} - #{comment.text}")
      end
    end
  end
end
