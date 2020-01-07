class DnsRecordBuilder
  attr_reader :dns_record

  def self.build
    builder = new
    yield(builder)
    builder.dns_record
  end

  def initialize
    @dns_record = DnsRecord.new
  end

  def ip=(ip)
    @dns_record.ip = ip
  end

  def hostnames=(hostnames)
    hostnames.each do |hostname|
      host = RelatedHostname.find_or_create_by(hostname)
      @dns_record.hostnames << host
    end
  end
end
