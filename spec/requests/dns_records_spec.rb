# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DnsRecords', type: :request do
  let(:valid_attributes) do
    build(:post_hash)
  end

  let(:invalid_attributes) do
    hash = build(:post_hash)
    hash[:dns_records].delete(:ip)
    hash
  end
  describe 'GET /dns_records' do
    it 'Fails when page is missing' do
      get dns_records_path
      expect(response).to have_http_status(400)
    end
  end
end
