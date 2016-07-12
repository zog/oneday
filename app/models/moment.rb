class Moment < ActiveRecord::Base
  include Concerns::CommonExtensions
  extend CarrierWave::Meta::ActiveRecord

  belongs_to :day

  mount_uploader :photo, ImageUploader
  serialize :photo_meta, OpenStruct

  carrierwave_meta_composed :photo_meta, :photo, image_version: %i(width height md5sum)

  validates :photo, presence: true, unless: :empty_record?

  def empty_record?
    !(legend.present? || time.present?)
  end

end
