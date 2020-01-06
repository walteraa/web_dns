require 'rails_helper'

RSpec.describe "DnsRecords", type: :request do
  describe "GET /dns_records" do
    it "works! (now write some real specs)" do
      get dns_records_path
      expect(response).to have_http_status(200)
    end
  end
end
