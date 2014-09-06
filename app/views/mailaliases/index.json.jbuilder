json.array!(@mailaliases) do |mailalias|
  json.extract! mailalias, :id, :cn, :rfc822mailmember, :description
  json.url mailalias_url(mailalias, format: :json)
end
