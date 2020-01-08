class ShowForm
  attr_reader :dns_records, :related_hostnames

  def initialize(dns_records, included, excluded)
    @records = dns_records
    @included = included
    @excluded = excluded
  end

  def related_hostnames
    hostnames = dns_records&.map(&:hostnames)
                                 &.flatten&.uniq(&:id)
    return hostnames if @included.blank? && @excluded.blank?

    if @included.present?
      hostnames = hostnames.select do |h|
        @included.include? h.hostname
      end
    end

    if @excluded.present?
      hostnames = hostnames.reject do |h|
        @excluded.include? h.hostname
      end
    end
    hostnames
  end

  def dns_records
    records = @records

    return records if @included.blank? && @excluded.blank?

    if @included.present?
      records = records.select do |r|
        r.hostnames.any? { |h| @included.include? h.hostname }
      end
    end

    if @excluded.present?
      records = records.reject do |r|
        r.hostnames.any? { |h| @excluded.include? h.hostname }
      end
    end

    records
  end
  def total_records
    dns_records.count
  end
end
