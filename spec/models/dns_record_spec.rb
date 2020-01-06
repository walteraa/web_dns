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
      let(:dns_entry_empty_ip) { build(:dns_record, ip_address: nil) }

      it { expect(dns_entry).to_not be_valid }
      it { expect(dns_entry_empty_ip).to_not be_valid }
    end
  end

  describe 'Relationship validation' do
    it { should have_and_belong_to_many(:related_hostnames) }
  end

  describe 'Uniqueness' do
    let(:ip) { Faker::Internet.public_ip_v4_address }
    before do
      create(:dns_record, ip_address: ip)
    end

    context 'repeated invalid' do
      let(:dns_record) { build(:dns_record, ip_address: ip) }
      it { expect(dns_record).to_not be_valid }
    end
  end
end
