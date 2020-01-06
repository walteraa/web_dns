# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsRecordsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dns_records').to route_to('dns_records#index')
    end

    it 'routes to #show' do
      expect(get: '/dns_records/1').to route_to('dns_records#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/dns_records').to route_to('dns_records#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/dns_records/1').to route_to('dns_records#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/dns_records/1').to route_to('dns_records#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/dns_records/1').to route_to('dns_records#destroy', id: '1')
    end
  end
end
