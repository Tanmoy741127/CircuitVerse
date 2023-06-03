# app/controllers/vuesimulator_controller.rb
# frozen_string_literal: true

class VuesimulatorController < ApplicationController
    require "net/http"
    def simulatorvue
      # Define the target URL you want to proxy to
      target_url = 'http://localhost:3002'

      # Make a GET request to the target URL
      response = Net::HTTP.get_response(URI(target_url))

      # Forward the response from the target URL
      render html: response.body, status: response.code.to_i
    end
  
    private
  
      def sanitize(html)
        ActionController::Base.helpers.sanitize(html)
      end
  end