class User < ApplicationRecord
  # has_many :favorites
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  before_validation :construct_api_key, on: :create

  def construct_api_key
    self.api_key = Digest::MD5.hexdigest(Time.now.to_s + "#{self.name}#{self.email}")
  end
end
