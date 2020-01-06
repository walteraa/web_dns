# frozen_string_literal: true

class RelatedHostnamesController < ApplicationController
  before_action :set_related_hostname, only: %i[show update destroy]

  # GET /related_hostnames
  def index
    @related_hostnames = RelatedHostname.all

    render json: @related_hostnames
  end

  # GET /related_hostnames/1
  def show
    render json: @related_hostname
  end

  # POST /related_hostnames
  def create
    @related_hostname = RelatedHostname.new(related_hostname_params)

    if @related_hostname.save
      render json: @related_hostname, status: :created, location: @related_hostname
    else
      render json: @related_hostname.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /related_hostnames/1
  def update
    if @related_hostname.update(related_hostname_params)
      render json: @related_hostname
    else
      render json: @related_hostname.errors, status: :unprocessable_entity
    end
  end

  # DELETE /related_hostnames/1
  def destroy
    @related_hostname.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_related_hostname
    @related_hostname = RelatedHostname.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def related_hostname_params
    params.require(:related_hostname).permit(:hostname)
  end
end
