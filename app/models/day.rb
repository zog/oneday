class Day < ActiveRecord::Base
  include Concerns::CommonExtensions
  include Concerns::NameInUrl

  belongs_to :user
  has_many :moments, dependent: :destroy
  accepts_nested_attributes_for :moments, reject_if: proc { |attributes| attributes.except("seq", "_destroy").values.all?(&:blank?) }, allow_destroy: true
  accepts_nested_attributes_for :user
  validates :country, presence: true
  as_param :build_permalink

  after_save do
    self.permalink = build_permalink.try(:parameterize)
    Day.where(id: self.id).update_all permalink: build_permalink.try(:parameterize)
  end

  def build_permalink
    "#{id}-one-day-in-#{country_name}"
  end

  def country_name
    _country = ISO3166::Country[country]
    _country.try :name
  end

  def location
    d = if lat.present? && lng.present?
      {lat: lat, lng: lng, zoom: 8}
    else
      c = ISO3166::Country[country]
      {lat: c.latitude_dec.to_f, lng: c.longitude_dec.to_f, zoom: 6}
    end
    OpenStruct.new d
  end

  def thumb
    moments.first
  end

  def random
    moments.order('random()').first
  end
end
