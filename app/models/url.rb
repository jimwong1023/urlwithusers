class Url < ActiveRecord::Base
  before_save :generate_key
  validates :original_url, format: {with: /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i}
  validates :original_url, presence: true

  belongs_to :user

  def generate_key
    self.key = (0..9).map{(65+rand(26)).chr}.join.downcase
  end
end
