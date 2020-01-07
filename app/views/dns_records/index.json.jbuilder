json.dns_records do
  json.total_records DnsRecord.count
  json.records @dns_records do |record|
    json.id record.id
    json.ip_address record.ip
  end
end
