require "paperclip/railtie"
Paperclip::Railtie.insert

# Paperclip.interpolates(:s3_eu_url) do |att, style|
#     "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
# end

# module AWS
#     module S3
#         DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
#     end
# end