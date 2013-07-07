# encoding: utf-8

class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog if Rails.env == 'production'

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def resize(size)
    manipulate! do |img|
      img.resize "#{size}!"
      img
    end
  end
end
