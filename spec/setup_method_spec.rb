# frozen_string_literal: true
RSpec.describe FollowUser do

  context 'not already following' do

    def setup_follow
      new_follower = User.new
      followee = User.new

      FollowUser.new(follower: new_follower, followee: followee).call
      [new_follower, followee]
    end

    it 'lets the follower see the new followee' do
      new_follower, followee = setup_follow
      expect(new_follower.followees).to include(followee)
    end

    it 'lets the followee see the new follower' do
      new_follower, followee = setup_follow
      expect(followee.followers).to include(new_follower)
    end
  end

  context 'blocked' do

    def setup_blocked_follow
      follower = User.new
      blocking_followee = User.new
      blocking_followee.blocked << follower

      FollowUser.new(follower: follower, followee: blocking_followee).call
      [follower, blocking_followee]
    end

    it 'does not let the follower see the new followee' do
      follower, blocking_followee = setup_blocked_follow
      expect(follower.followees).not_to include(blocking_followee)
    end

    it 'does not let the followee see the new follower' do
      follower, blocking_followee = setup_blocked_follow
      expect(blocking_followee.followers).not_to include(follower)
    end
  end

end
