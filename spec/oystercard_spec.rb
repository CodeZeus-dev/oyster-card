require 'oystercard'
require 'station'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) {double :station}
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

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

    it 'stores the entry station to an instance variable upon initialisation' do
      expect(subject.entry_station).to eq nil
    end

    it 'stores the exit station to an instance variable upon initialisation' do
      expect(subject.exit_station).to eq nil
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

    it "changes the in_journey instance variable to true" do
      subject.top_up(25)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it "raises an Exception if balance is below £1" do
      expect { subject.touch_in(entry_station) }.to raise_error(Exception, "Sorry, insufficient funds.")
    end

    it 'stores the entry station into the entry_station instance variable' do
      subject.top_up(25)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe "#touch_out" do
    it "can be called on an Oystercard instance" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it "changes the in_journey instance variable to false" do
      subject.top_up(25)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq(false)
    end

    it "charges the Oystercard the minimum fare" do
      subject.top_up(25)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "raises an Exception if user hasn't touched in and tries to touch out" do
      expect { subject.touch_out(exit_station) }.to raise_error(Exception, "You need to touch in first!")
    end

    it "sets @entry_station to nil" do
      subject.top_up(25)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'stores the exit station into the exit_station instance variable' do
      subject.top_up(25)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    it "stores the journey to the trip_history array" do
      subject.top_up(25)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.trip_history).to include(journey)
    end
  end
end
