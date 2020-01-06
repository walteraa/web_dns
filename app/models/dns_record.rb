# frozen_string_literal: true

require 'resolv'

class DnsRecord < ApplicationRecord
  validates :ip_address, format: { with: Resolv::IPv4::Regex }
end
