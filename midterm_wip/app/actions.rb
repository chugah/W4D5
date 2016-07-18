# Homepage (Root path)
get '/' do
  if session[:company_id]
    @company = Company.find(session[:company_id])
  end
  erb :index
end

post '/login' do
  if @company = Company.find_by_username(params[:username])
    session[:company_id] = @company.id
    session[:id] = params[:id]
    redirect '/dashboard'
  else
    redirect '/register'
  end
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    )
  if @user.save 
    session[:company_id] = @user.id
    redirect '/dashboard'
  else
    erb :register
  end
end

get '/dashboard' do
  if session[:company_id]
    @company = CompanyProfile.find_by(session[:company_id])
  else
    redirect '/register'
  end
  erb :'dashboard/index'
end



=begin

THIS CODE WORKS

post '/login' do
  session[:username] = params[:username]
  redirect '/dashboard/:username'
end

get '/dashboard/:username' do
  @user = User.all
  erb :dashboard 
end

===================

THIS CODE WORKS
get '/' do
  erb :index
end

post '/login' do
  session[:username] = params[:username]
  redirect '/dashboard/:username'
end

get '/dashboard/:username' do
  @company_profiles = CompanyProfile.all
  erb :dashboard 
end

=================

THIS CODE WORKS

get '/' do
  erb :index
end

post '/login' do
  redirect '/dashboard'
end

get '/dashboard' do
  @company_profiles = CompanyProfile.all
  erb :dashboard
end


=====================

THIS CODE WORKS AS WELL

get '/' do
  erb :index
end

post '/login' do
  session[:username] = params[:username]
  session[:password] = params[:password]
  session[:email] = params[:email]
  redirect '/dashboard/:username'
end

get '/dashboard/:username' do
  erb :dashboard
end

=====================

THIS CODE WORKS TOO
get '/' do
  erb :index
end

post '/login' do
  redirect '/dashboard'
end

get '/dashboard' do
  @companies = Company.all
  erb :dashboard
end

======================
THIS CODE ALSO WORKS

get '/' do
  erb :index
end

post '/login' do
  redirect '/dashboard'
end

get '/dashboard' do
  @company_profiles = CompanyProfile.all
  erb :dashboard
end

=end

