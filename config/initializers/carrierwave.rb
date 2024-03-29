CarrierWave.configure do |config|
  if Rails.env == 'production'
    config.root = Rails.root.join('tmp') # adding these...
    config.cache_dir = 'carrierwave' # ...two lines

    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'eu-west-1'
    }
    config.fog_directory  = 'BUCKET-NAME'
    config.asset_host     = 'http://s3-eu-west-1.amazonaws.com/BUCKET-NAME'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
  end
end