class AvatarUploader < CarrierWave::Uploader::Base
  include PublicUploader
  include CarrierWave::RMagick
  include CarrierWave::Meta
  include Sprockets::Rails::Helper

  process store_meta: [{md5sum: true}]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename
      # hash = Digest::MD5.hexdigest(File.dirname(current_path))
      name = file.basename.split('_').last.gsub(/\.$/, '')
      # ["#{name}-#{hash}", file.extension].compact.select(&:present?).join('.')
      [name, file.extension].compact.select(&:present?).join('.')
    end
  end

  def default_url
    "/assets/" + [version_name, "default.png"].compact.join('_')
  end

  version :medium do
    process resize_to_fill: [120, 120]
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end

  def resize_to_fill (*args)
    args = args[0].call if args[0].is_a?(Proc)

    gravity_key = :"#{mounted_as}_gravity"
    if self.model.respond_to?(gravity_key) && gravity = self.model.send(gravity_key)
      args[2] = "Magick::#{gravity.camelize}Gravity".constantize
    end

    super(*args)
  end
end
