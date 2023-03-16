# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require "spec_helper"

RSpec.describe TheOneApi do
  describe ".get" do
    context "with valid endpoint and API key" do
      before do
        allow(ENV).to receive(:[]).with("THE_ONE_API_KEY").and_return("test_key")
      end

      context "with valid options" do
        it "returns data for a single movie" do
          response = TheOneApi.call(endpoint: :movie, film: 1)
          expect(response["name"]).to eq("The Fellowship of the Ring")
        end

        it "returns data for movie quotes" do
          response = TheOneApi.call(endpoint: :quote, film: 1)
          expect(response).to be_an(Array)
          expect(response.length).to be > 0
        end

        it "returns data with pagination" do
          response = TheOneApi.call(endpoint: :movie, limit: 5, page: 1)
          expect(response).to be_an(Array)
          expect(response.length).to eq(5)
        end

        it "returns data with offset" do
          response = TheOneApi.call(endpoint: :movie, limit: 5, offset: 5)
          expect(response).to be_an(Array)
          expect(response.length).to eq(5)
        end
      end

      context "with invalid options" do
        it "ignores unknown options" do
          response = TheOneApi.call(endpoint: :movie, foo: "bar")
          expect(response).to be_an(Array)
          expect(response.length).to be > 0
        end

        it "ignores options that are not film, limit, page, or offset" do
          response = TheOneApi.call(endpoint: :movie, film: 1, foo: "bar")
          expect(response["name"]).to eq("The Fellowship of the Ring")
        end
      end
    end

    context "with invalid endpoint" do
      it "raises an ArgumentError" do
        expect { TheOneApi.call(:wrong) }.to raise_error(ArgumentError, "Invalid endpoint: wrong")
      end
    end

    context "with invalid API key" do
      before do
        allow(ENV).to receive(:[]).with("THE_ONE_API_KEY").and_return(nil)
      end

      it "raises an HTTParty::Unauthorized error" do
        expect { TheOneApi.call(endpoint: :movie, film: 1) }.to raise_error(HTTParty::Unauthorized)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
