# frozen_string_literal: true
class User
  attr_reader *%i(followers followees blocked)

  def initialize
    @followers = []
    @followees = []
    @blocked = []
  end
end
