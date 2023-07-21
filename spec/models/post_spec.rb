require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'John Doe', photo: 'photo_url', bio: 'bio_text', post_counter: 0)
  subject do
    Post.create(title: 'Test', text: 'Post content', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end

  it 'title must be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should be greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should be greater than or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should update the PostCounter attribute of the associated user' do
    expect(user.post_counter).to eq(0)

    subject.update_posts_counter

    expect(user.reload.post_counter).to eq(1)
  end

  it 'should five most recent post' do
    expect(subject.five_most_recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
