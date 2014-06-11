require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end


# ------------------------------------------ My methods ------------------------------------------
def get_meetups
  Meetup.all
end

def get_meetup_info(meetup_id)
  Meetup.where(id: meetup_id).first
end

def create_new_meetup(name, desc, location)
  Meetup.create(name: name, description: desc, location: location)
end

def get_meetup_by_name(name)
  Meetup.where(name: name).first
end

def join_meetup(user_id, meetup_id)
  UserMeetup.create(user_id: user_id, meetup_id: meetup_id)
end

def leave_meetup(user_id, meetup_id)
  record = UserMeetup.find_by(user_id: user_id, meetup_id: meetup_id)
  record.destroy
end

# def display_members(meetup_id)
#   members = UserMeetup.where(meetup_id: meetup_id)
#   members.each do |m|
#     puts User.where(id: m.id)
#     binding.pry
#   end
# end

def groups_joined
  if signed_in?
    current_user.meetups
  end
end

def member_of_group
  if signed_in?
    groups = current_user.meetups.map { |meet| meet.id }
  end
end

def post_comment(title, body, meetup_id)
  Comment.create(title: title, body: body, meetup_id: meetup_id)
end

def read_comments(id)
  comments = Comment.where(meetup_id: id)
  comments.order(created_at: :desc)
end

# ------------------------------------------ Routes ------------------------------------------
get '/' do
  @joined = groups_joined
  @signed_in = signed_in?
  @meetups = get_meetups.order(name: :asc)
  erb :index
end

get '/meetup/:id' do
  @comments = read_comments(params[:id])
  @member_of_group = member_of_group
  @signed_in = signed_in?
  @meetup = get_meetup_info(params[:id])
  erb :meetup
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

post '/' do
  create_new_meetup(params[:meetup_name], params[:description], params[:location])
  id = get_meetup_by_name(params["meetup_name"]).id
  flash[:notice] = "Your Meetup has been submitted"
  redirect "/meetup/#{id}"
end

post '/meetup/join/:id' do
  join_meetup(session[:user_id], params[:id])

  flash[:notice] = "You have joined this group"
  redirect "/meetup/#{params[:id]}"
end

post '/meetup/leave/:id' do
  leave_meetup(session[:user_id], params[:id])

  flash[:notice] = "You have left this group"
  redirect '/'
end

post '/meetup/comment/:id' do
  post_comment(params[:comment_title], params[:comment_body], params[:id])

  flash[:notice] = "Your comment has been submitted"
  redirect "/meetup/#{params[:id]}"
end
