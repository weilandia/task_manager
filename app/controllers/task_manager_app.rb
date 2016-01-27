require 'models/task_manager'

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    @tasks = task_manager.all
    erb :dashboard
  end

  # get '/tasks' do
  #   @tasks = task_manager.all
  #   erb :index
  # end

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

  def task_manager
    database = YAML::Store.new('db/task_manager')
    @task_manager ||= TaskManager.new(database)
  end
end
