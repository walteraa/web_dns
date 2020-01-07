# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dns_records, defaults: { format: 'json' }
end
