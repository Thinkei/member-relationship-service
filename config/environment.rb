require 'require_all'

require_relative 'initializers/configurations'
require_relative 'initializers/database'

require_all 'lib'
require_all 'app/helpers'
require_all 'app/models'
require_all 'app/services'
