# frozen_string_literal: true
RSpec.describe FollowUser do

  let(:follower) { User.new }
  let(:new_followee) { User.new }
  let(:blocking_followee) { User.new }

  before do
    blocking_followee.blocked << follower
  end

  subject { FollowUser.new(follower: follower, followee: followee) }

  context 'not already following' do
    let(:followee) { new_followee }

    before do
      subject.call
    end

    it 'lets the follower see the new followee' do
      expect(follower.followees).to include(followee)
    end

    it 'lets the followee see the new follower' do
      expect(followee.followers).to include(follower)
    end
  end

  context 'blocked' do
    let(:followee) { blocking_followee }

    before do
      subject.call
    end

    it 'does not let the follower see the new followee' do
      expect(follower.followees).not_to include(followee)
    end

    it 'does not let the followee see the new follower' do
      expect(followee.followers).not_to include(follower)
    end
  end

end
