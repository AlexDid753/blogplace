# Use this module to configure the sabisu available options

SabisuRails.setup do |config|

  config.base_api_uri = 'localhost:3000'
  config.api_headers = { "Accept" => "application/vnd.blogplace.v1" }
  config.resources = [:users]
  config.default_resource = :users

  # Authentication
  # mattr_accessor :authentication_username
  # @@authentication_username = "admin"

  # mattr_accessor :authentication_password
  # @@authentication_password = "sekret"
end
