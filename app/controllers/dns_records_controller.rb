# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  before_action :set_dns_record, only: %i[show update destroy]

  # GET /dns_records
  def index
    @dns_records = DnsRecord.all

    render json: @dns_records
  end

  # GET /dns_records/1
  def show
    render json: @dns_record
  end

  # POST /dns_records
  def create
    @dns_record = DnsRecord.new(dns_record_params)

    if @dns_record.save
      render json: @dns_record, status: :created, location: @dns_record
    else
      render json: @dns_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dns_records/1
  def update
    if @dns_record.update(dns_record_params)
      render json: @dns_record
    else
      render json: @dns_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dns_records/1
  def destroy
    @dns_record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dns_record
    @dns_record = DnsRecord.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dns_record_params
    params.require(:dns_record).permit(:ip_address)
  end
end
