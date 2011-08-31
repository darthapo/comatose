require 'fileutils'

# Copy the images (*.gif) into Rails.root/public/images/comatose
Rails.root = File.expand_path( File.join(File.dirname(__FILE__), '../../../') )

unless FileTest.exist? File.join(Rails.root.to_s, 'public', 'images', 'comatose')
  FileUtils.mkdir( File.join(Rails.root.to_s, 'public', 'images', 'comatose') )
end

FileUtils.cp( 
  Dir[File.join(File.dirname(__FILE__), 'resources', 'public', 'images', '*.gif')], 
  File.join(Rails.root.to_s, 'public', 'images', 'comatose'),
  :verbose => true
)

# Show the INSTALL text file
puts IO.read(File.join(File.dirname(__FILE__), 'INSTALL'))

