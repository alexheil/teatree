require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment

  process(:store) do |io|
    original = io.download
    processor = ImageProcessing::MiniMagick

    size_460 = processor.source(original).resize_to_limit!(460, 460)

    original.close!

    { original: io, thumb: size_460 }
  end

  Attacher.validate do
    validate_max_size 15.megabyte, message: "is too large (max is 1 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

end