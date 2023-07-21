require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'test', photo: 'photo1', bio: 'bio', post_counter: 0) }

  it 'name must be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should be greater than or equal to zero' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should three most recent post' do
    expect(subject.three_most_recent_posts).to eq(subject.posts.order(updated_at: :desc).limit(3))
  end
end
