# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsRecordsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dns_records').to route_to('dns_records#index',
                                              format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/dns_records').to route_to('dns_records#create',
                                               format: 'json')
    end
  end
end
