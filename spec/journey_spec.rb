require 'journey'

describe Journey do
  let(:station) { Station.new("Aldgate East", 1)}

  it "creates an instance of Journey" do
    expect(subject).to be_instance_of(described_class)
  end

  describe "#initialize" do
    it "creates an empty_station instance variable upon initialisation" do
      expect(subject.entry_station).to eq nil
    end

    it "creates an exit_station instance variable upon initialisation" do
      expect(subject.exit_station).to eq nil
    end

    it "assigns the values passed in as arguments to the entry and exit station variables" do
      journey = Journey.new("Bank", "Canary Wharf")
      expect([journey.entry_station, journey.exit_station]).to eq ["Bank", "Canary Wharf"]
    end

    it "initialises the complete instance variable by setting it to false" do
      expect(subject.complete).to eq(false)
    end
  end

  describe "#fare" do
    it "can be called on an oystercard" do
      expect(subject).to respond_to(:fare)
    end

    it "returns either the single journey fare or the penalty fee depending on @complete" do
      expect(subject.fare).to eq(Journey::SINGLE_JOURNEY_FARE).or eq(Journey::PENALTY_FEE)
    end
  end

  describe "#finish" do
    it "can be called on an oystercard" do
      expect(subject).to respond_to(:finish).with(1).argument
    end

    it "sets @exit_station equal to its argument" do
      subject.finish(station)
      expect(subject.exit_station).to eq(station)
    end

    it "sets complete to true" do
      subject.finish(station)
      expect(subject.complete).to eq(true)
    end
  end
end