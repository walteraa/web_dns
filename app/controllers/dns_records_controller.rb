# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  before_action :set_dns_record, only: %i[show update destroy]

  # GET /dns_records
  def index
    @dns_records = DnsRecord.all

    render json: @dns_records
  end

  # POST /dns_records
  def create
    @dns_record = DnsRecord.new(dns_record_params)

    if @dns_record.save
      render json: { id: @dns_record.id }, status: :created
    else
      render json: @dns_record.errors, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    render nothing: true, status: :bad_request
  end

  private

  # Only allow a trusted parameter "white list" through.
  def dns_record_params
    params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
  end
end
