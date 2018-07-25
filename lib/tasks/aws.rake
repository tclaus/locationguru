

namespace :aws do
  namespace :rename do
    desc "Moves all s3 files to a new destination"
    task media: :environment do
      # Instead of 'Photo' use your own object
      bucketName = ENV['s3_bucket_name']
      Photo.all.each do |m|
        [:original, :medium, :thumb].each do |style|

          # Set your Credentials and Region
          s3 = Aws::S3::Resource.new(region: 'eu-central-1',
            access_key_id: ENV['s3_key_id'],
            secret_access_key: ENV['s3_access_key'],
            endpoint: 'https://s3-eu-central-1.amazonaws.com')

          key = "photos/#{m.id}/#{style}/#{m.image_file_name}"
          object = s3.bucket(bucketName).object(key)
          next unless object.exists?
          hash = m.image.hash_key style
          copy_key = "photos/#{m.id}/#{style}/#{hash}" + File.extname(m.image_file_name)
          puts "ID: #{m.id}, Hash: #{m.image.hash}"

          object.copy_to(bucket: bucketName ,key: copy_key)

          client = Aws::S3::Client.new(region: 'eu-central-1',
            access_key_id: ENV['s3_key_id'],
            secret_access_key: ENV['s3_access_key'],
            endpoint: 'https://s3-eu-central-1.amazonaws.com')

          client.put_object_acl({
            acl: "public-read",
            bucket: bucketName,
            key: copy_key,
          })

        end
      end
    end
  end
end
