require 'spec_helper'

describe Remitano::Client::Net do
  describe "#server" do
    context "REMITANO_SERVER not set, REMITANO_SANDBOX not set" do
      it "returns production server" do
        stub_const(
          "ENV",
          ENV.to_hash.merge(
            "REMITANO_SERVER" => nil,
            "REMITANO_SANDBOX" => nil
          )
        )
        expect(Remitano::Client::Net.server).to eq Remitano::Client::Net::REMITANO_PRODUCTION_SERVER
      end
    end

    context "REMITANO_SERVER not set, REMITANO_SANDBOX set to true" do
      it "returns sandbox server" do
        stub_const(
          "ENV",
          ENV.to_hash.merge(
            "REMITANO_SERVER" => nil,
            "REMITANO_SANDBOX" => "true"
          )
        )
        expect(Remitano::Client::Net.server).to eq Remitano::Client::Net::REMITANO_SANDBOX_SERVER
      end
    end

    context "REMITANO_SERVER not set, REMITANO_SANDBOX set to false" do
      it "returns production server" do
        stub_const(
          "ENV",
          ENV.to_hash.merge(
            "REMITANO_SERVER" => nil,
            "REMITANO_SANDBOX" => "false"
          )
        )
        expect(Remitano::Client::Net.server).to eq Remitano::Client::Net::REMITANO_PRODUCTION_SERVER
      end
    end

    context "REMITANO_SERVER set to a specific server" do
      it "returns specified server" do
        stub_const(
          "ENV",
          ENV.to_hash.merge(
            "REMITANO_SERVER" => "https://someserver.com",
            "REMITANO_SANDBOX" => "true"
          )
        )
        expect(Remitano::Client::Net.server).to eq "https://someserver.com"
      end
    end
  end
end
