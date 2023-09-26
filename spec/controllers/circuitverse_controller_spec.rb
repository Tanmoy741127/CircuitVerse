# frozen_string_literal: true

require "rails_helper"

describe CircuitverseController do
  it "gets index page" do
    get root_path
    expect(response).have_http_status(200)
  end

  it "gets examples page" do
    get examples_path
    expect(response).have_http_status(200)
  end

  it "gets tos page" do
    get tos_path
    expect(response).have_http_status(200)
  end

  it "gets teachers page" do
    get teachers_path
    expect(response).have_http_status(200)
  end

  it "gets contribute page" do
    get contribute_path
    expect(response).have_http_status(200)
  end
end
