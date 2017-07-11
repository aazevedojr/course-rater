require 'csv'
require_relative 'registration'
require_relative 'new_challenge'
require_relative 'csv2db'
require_relative 'db2csv'
require_relative 'setup'

# From setup:
create_db

# From csv2db:
challenge_id = import_challenge

# From db2csv:
save_results(challenge_id)