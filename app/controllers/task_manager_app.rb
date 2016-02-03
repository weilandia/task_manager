require 'yaml/store'

class TaskManagerApp < Sinatra::Base
  get '/' do
    @tasks = task_manager.all
    erb :dashboard
  end

  get '/tasks/new' do
    erb :new
  end

  post '/' do
    task_manager.create(params[:task])
    redirect '/'
  end

  get '/tasks/:id' do |id|
    @task = task_manager.find(id.to_i)
    erb :show
  end

  get '/tasks/:id/edit' do |id|
    @task = task_manager.find(id.to_i)
    erb :edit
  end

  put '/tasks/:id' do |id|
    task_manager.update(params[:task], id.to_i)
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id/complete' do |id|
    task_manager.delete(id.to_i)
    redirect '/'
  end

  not_found do
    erb :error
  end

  def task_manager
    database = YAML::Store.new('db/task_manager')
    @task_manager ||= TaskManager.new(database)
  end
end
