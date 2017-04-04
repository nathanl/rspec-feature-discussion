# frozen_string_literal: true
RSpec.describe FollowUser do

  context 'not already following' do
    it 'lets the follower see the new followee' do
      follower = User.new
      new_followee = User.new

      FollowUser.new(follower: follower, followee: new_followee).call
      expect(follower.followees).to include(new_followee)
    end

    it 'lets the followee see the new follower' do
      follower = User.new
      new_followee = User.new

      FollowUser.new(follower: follower, followee: new_followee).call
      expect(new_followee.followers).to include(follower)
    end
  end

  context 'blocked' do
    it 'does not let the follower see the new followee' do
      follower = User.new
      blocking_followee = User.new
      blocking_followee.blocked << follower

      FollowUser.new(follower: follower, followee: blocking_followee).call
      expect(follower.followees).not_to include(blocking_followee)
    end

    it 'does not let the followee see the new follower' do
      follower = User.new
      blocking_followee = User.new
      blocking_followee.blocked << follower

      FollowUser.new(follower: follower, followee: blocking_followee).call
      expect(blocking_followee.followers).not_to include(follower)
    end
  end

end
