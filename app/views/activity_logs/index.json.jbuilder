json.array!(@activity_logs) do |activity_log|
  json.extract! activity_log, :id, :item_type, :item_id, :act_action, :updated_by, :activity, :act_tstamp
  json.url activity_log_url(activity_log, format: :json)
end
