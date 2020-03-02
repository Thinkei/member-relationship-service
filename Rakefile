require 'require_all'
require_relative './config/eh_micro'
require_all './config/initializers'

Dir[File.expand_path('lib/tasks/*.rake', __dir__)].each do |task_path|
  load task_path
end
