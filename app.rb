require 'braintree'
require "rubygems"
require 'sinatra'
require 'sinatra/activerecord'

configure :development, :test do
  set :database, 'sqlite3:development.db'
end

configure :production do
  # Database connection
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  pool = ENV["DB_POOL"] || ENV['MAX_THREADS'] || 5

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8',
    :pool => pool
  )
end

gateway = Braintree::Gateway.new(
  :client_id => "client_id$sandbox$h92cnzmcmsfcsvhv",
  :client_secret => "client_secret$sandbox$af1565bda3835e96c64ca697446a5436",
)

get "/" do
  @url = gateway.oauth.connect_url(
    :merchant_id => "yxb4zvxjdctbbppt",
    :redirect_uri => "http://integration-test-app.herokuapp.com",
    :scope => "grant_payment_method"
  )
  p @url
  erb :index
end
