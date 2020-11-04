require 'journey'

describe Journey do

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
  end

end