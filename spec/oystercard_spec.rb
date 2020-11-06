require 'oystercard'
require 'station'

describe Oystercard do

  let(:station) { Station.new("Leicester Square", 1) }

  it "returns an instance of Oystercard class" do
    expect(subject).to be_instance_of(Oystercard)
  end

  describe "#initialize" do
    it "initializes the card with 0 balance in it" do
      expect(subject.balance).to eq(0)
    end

    it 'stores the trip history as an instance variable' do
      expect(subject.trip_history).to be_empty
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
      expect { subject.top_up(Oystercard::MINIMUM_FARE) }.to raise_error(Exception, "Top-up failed - Balance exceeding £90")
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
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it "raises an Exception if balance is below £1" do
      expect { subject.touch_in(station) }.to raise_error(Exception, "Sorry, insufficient funds.")
    end

    it "returns an instance of the Journey class" do
      subject.top_up(25)
      subject.touch_in(station)
      expect(subject.journey).to be_instance_of(Journey)
    end
  end

  describe "#touch_out" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it "changes the in_journey instance variable to false" do
      subject.top_up(25)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it "charges the Oystercard the minimum fare" do
      subject.top_up(25)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "stores the journey to the trip_history array" do
      subject.top_up(25)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.trip_history).not_to be_empty
    end
  end
end
