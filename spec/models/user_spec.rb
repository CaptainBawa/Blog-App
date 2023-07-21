require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(Name: 'test', Photo: 'photo1', Bio: 'bio') }

  before { subject.save }

  it 'name must be present' do
    subject.Name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be greater than or equal to zero' do
    subject.PostCounter = -1
    expect(subject).to_not be_valid
  end

  it 'return three most recent post' do
    expect(subject.three_most_recent_posts).to eq(subject.posts.order(updated_at: :desc).limit(3))
  end
end
