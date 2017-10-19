
class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :author_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :author_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :url_id

  has_many :visitors,
    through: :visits,
    source: :user

  def self.random_code
    code = nil
    until code
      code = SecureRandom.urlsafe_base64
      if ShortenedUrl.exists?(short_url: code)
        code = nil
      end
    end
    code
  end

  def self.generate!(user, long_url)
    code = self.random_code

    self.create(long_url: long_url, short_url: code, author_id: user.id)
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    visits.select(:visitor_id).distinct.length
  end

  def num_recent_uniques
    visits.select(:visitor_id).distinct.where({ created_at: 10.minutes.ago..Time.now }).length
  end
end
