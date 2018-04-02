require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

get '/' do
    erb :home
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end

get '/gallery' do
  erb :gallery
end

get '/sign-up' do
  erb :sign_up
end

get '/completed' do
  erb :completed
end

post '/completed' do
  puts "PARAMS"
  puts params.inspect
  puts "PARAMS"

  @my_first_name = params[:first_name]
  @my_last_name = params[:last_name]
  @my_email = params[:email]
  @company = params[:company]
  puts @my_email

  from = Email.new(email: "joseph@mysite.com")
  to = Email.new(email: @my_email)
  subject = "Welcome aboard, #{@my_first_name} #{@my_last_name}!"
  content = Content.new(type: "text/plain", value: "Welcome aboard #{@my_first_name} #{@my_last_name}. We're so excited to have you on board with us, along with all your co-workers at #{@company}!")

  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
  erb :completed
end
