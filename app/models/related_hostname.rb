# frozen_string_literal: true

class RelatedHostname < ApplicationRecord
  validates :hostname,
            format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\Z/ }
  validates :hostname, uniqueness: true
  has_and_belongs_to_many :dns_records
end
