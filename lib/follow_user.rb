# frozen_string_literal: true
class FollowUser
  def initialize(follower:, followee:)
    @follower = follower
    @followee = followee
  end

  def call
    unless followee.blocked.include?(follower)
      follower.followees << followee
      followee.followers << follower
    end
  end

  private

  attr_reader *%i(follower followee)
end
