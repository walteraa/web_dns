# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  describe 'IP Validator' do
    context 'Valid IP' do
      let(:dns_entry) { build(:dns_record) }

      it { expect(dns_entry).to be_valid }
    end

    context 'Invalid IP' do
      let(:dns_entry) { build(:dns_record, :with_invalid_ip) }

      it { expect(dns_entry).to_not be_valid }
    end
  end
end
