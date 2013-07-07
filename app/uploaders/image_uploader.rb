class ImageUploader < BaseUploader
  def extension_white_list
    %w( jpg jpeg gif png )
  end

  # Custom methods
  def set_width(width)
    manipulate! do |img|
      scale = width.to_f / img['width'].to_f
      new_height = img['height'].to_f * scale
      img.resize("#{width}x#{new_height}")
      img
    end
  end

  def set_height(height)
    manipulate! do |img|
      scale = height.to_f / img['height'].to_f
      new_width = img['width'].to_f * scale
      img.resize("#{new_width}x#{height}")
      img
    end
  end

  def set_square(side)
    manipulate! do |img|
      img = img['width'] > img['height'] ? set_width(200) : set_height(200)
      img.combine_options do |mogrify|
        mogrify.gravity 'center'
        mogrify.background 'transparent'
        mogrify.extent "#{side}x#{side}"
      end
      img
    end
  end
end
