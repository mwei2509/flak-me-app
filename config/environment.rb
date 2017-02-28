# Load the Rails application.
require File.expand_path('../application', __FILE__)

configure :production do
  db = URI.parse(ENV['HEROKU_POSTGRESQL_COPPER_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
      )
end
# Initialize the Rails application.
Rails.application.initialize!
