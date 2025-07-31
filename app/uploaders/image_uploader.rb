class ImageUploader < Shrine
  # Add any processing plugins here if needed
  plugin :validation_helpers
  plugin :determine_mime_type
  plugin :store_dimensions

  # Validate file type
  Attacher.validate do
    validate_mime_type_inclusion [ "image/jpeg", "image/png", "image/gif" ]
    validate_max_size 5 * 1024 * 1024 # 5MB
  end
end
