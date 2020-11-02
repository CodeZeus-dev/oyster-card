require 'oystercard'

describe Oystercard do
  it "returns an instance of Oystercard class" do
    expect(subject).to be_instance_of(Oystercard)
  end

  describe "#initialize" do
    it "initializes the card with 0 balance in it" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "adds funds to the card's balance" do
      expect { subject.top_up(1) }.to change { subject.balance }.from(0).to(1)
    end

    it "raises an Exception when balance exceeds the limit value" do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.top_up(1) }.to raise_error(Exception, "Top-up failed - Balance exceeding £90")
    end
  end

  describe "#deduct" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "deducts a fare from an Oystercard instance" do
      expect { subject.deduct(1) }.to change { subject.balance }.by(-1)
    end
  end

  describe "#in_journey?" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "returns a boolean depending on whether the user is in journey or not" do
      expect(subject.in_journey?).to eq(false).or eq(true)
    end
  end

  describe "#touch_in" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:touch_in)
    end

    it "changes the in_journey instance variable to true" do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end

  describe "#touch_out" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:touch_out)
    end

    it "changes the in_journey instance variable to false" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
  end
end
