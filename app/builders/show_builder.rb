module Forms
  class ShowForm
    attr_reader :dns_records, :related_hostnames

    def initialize(dns_records, related_hostnames, excluded, included)
      @dns_records = dns_records
      @related_hostnames = related_hostnames
      @included = included
      @excluded = excluded
    end

    def related_hostnames
      @related_hostnames = @dns_records&.map(&:hostnames)
                                       &.flatten&.uniq(&:id)
      return @related_hostnames if @included.blank? && @excluded.blank?

      @related_hostnames = @related_hostnames.select do |h|
        @included.include? h.hostname
      end
      @related_hostnames = @related_hostnames.reject do |h|
        @excluded.include? h.hostname
      end
    end
  end
end
