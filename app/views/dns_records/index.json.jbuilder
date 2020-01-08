json.dns_records do
  json.total_records @form&.total_records
  json.records @form&.dns_records do |record|
    json.id record.id
    json.ip_address record.ip
  end
  json.related_hostnames @form&.related_hostnames do |host|
    json.hostname host.hostname
    json.count host.dns_records.count
  end
end
