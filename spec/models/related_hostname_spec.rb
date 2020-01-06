# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelatedHostname, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe 'Hostname validation' do
    context 'Valid hostname' do
      let(:related_host) { build(:related_hostname) }

      it { expect(related_host).to be_valid }
    end

    context 'Invalid hostname' do
      let(:related_host) { build(:related_hostname, :with_invalid_hostname) }
      let(:related_host_without_hostname) do
        build(:related_hostname,
              hostname: nil)
      end

      it { expect(related_host).to_not be_valid }
      it { expect(related_host_without_hostname).to_not be_valid }
    end

    describe 'Relationship validation' do
      it { should have_and_belong_to_many(:dns_records) }
    end
  end

  describe 'Uniqueness' do
    let(:hostname) { Faker::Internet.domain_name(subdomain: true) }
    before do
      create(:related_hostname, hostname: hostname)
    end

    context 'repeated invalid' do
      let(:related_hostname) { build(:related_hostname, hostname: hostname) }
      it { expect(related_hostname).to_not be_valid }
    end
  end
end
