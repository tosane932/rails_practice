json.extract! learning_log, :id, :learned_on, :duration_mins, :memo, :created_at, :updated_at
json.url learning_log_url(learning_log, format: :json)
