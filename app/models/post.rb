class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_rich_text :description

  scope :pro,  -> { where(pro: true) }
  scope :free, -> { where(pro: false) }

  validates :title, presence: true
  validates :description, presence: false
  validates :thumbnail_url, presence: false
  validates :video_url, presence: true

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def to_s
    title
  end
end
