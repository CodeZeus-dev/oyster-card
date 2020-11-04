require 'station'

describe Station do

  let(:station) { described_class.new("White City", 2) }

  it "returns an instance of its own" do
    expect(station).to be_instance_of(Station)
  end

  describe "#initialize" do
    it "creates a name instance variable upon initialisation" do
      expect(station.name).to eq "White City"
    end

    it "creates a zone instance variable upon initialisation" do
      expect(station.zone).to eq 2
    end
  end
end
