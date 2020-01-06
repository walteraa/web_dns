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

      it { expect(related_host).to_not be_valid }
    end

    describe 'Relationship validation' do
      it { should have_and_belong_to_many(:dns_records) }
    end
  end
end
