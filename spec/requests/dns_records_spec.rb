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

  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /dns_records' do
    let(:attributes) { valid_attributes.fetch(:dns_records) }
    let(:first_dns_record) do
      DnsRecordBuilder.build do |builder|
        builder.ip = attributes[:ip]
        builder.hostnames = attributes[:hostnames_attributes]
      end
    end

    let(:second_dns_record) do
      DnsRecordBuilder.build do |builder|
        builder.ip = '192.168.0.1'
        builder.hostnames = attributes[:hostnames_attributes]
      end
    end

    before do
      first_dns_record.save
      second_dns_record.save
    end

    context 'page param missing' do
      it 'Fails when page is missing' do
        get dns_records_path
        expect(response).to have_http_status(400)
      end
    end

    context 'page params passed' do
      before { get dns_records_path, params: { page: 1 } }
      it 'returns a success response' do
        expect(response).to have_http_status(200)
      end
      it { expect(response_json['dns_records']['total_records']).to be(2) }
      it do
        expect(response_json['dns_records']['records'].map do |r|
          r['id']
        end).to match([first_dns_record.id, second_dns_record.id])
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new DnsRecord' do
        expect do
          post dns_records_path, params: valid_attributes
        end.to change(DnsRecord, :count).by(1)
      end

      it 'renders a JSON response with the new dns_record id' do
        post dns_records_path, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response_json['id']).to_not be_nil
      end
    end
  end
end
