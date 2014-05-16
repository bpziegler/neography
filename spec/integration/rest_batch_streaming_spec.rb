require 'spec_helper'

describe Neography::Rest do
  before(:each) do
    @neo = Neography::Rest.new
  end
  
  describe "streaming" do
  
    it "can send a 1000 item batch" do
      commands = []
      1000.times do |x|
        commands << [:create_node, {"name" => "Max " + x.to_s}]
      end
      batch_result = @neo.batch *commands
      expect(batch_result.first["body"]["data"]["name"]).to eq("Max 0")
      expect(batch_result.last["body"]["data"]["name"]).to eq("Max 999")
    end

    it "can send a 5000 item batch" do
      commands = []
      5000.times do |x|
        commands << [:get_node, 0]
      end
      batch_result = @neo.batch *commands
      expect(batch_result.first["body"]["self"].split('/').last).to eq("0")
      expect(batch_result.last["body"]["self"].split('/').last).to eq("0")
    end

    it "can send a 7000 get item batch" do
      commands = []
      7000.times do |x|
        commands << [:get_node, 0]
      end
      batch_result = @neo.batch *commands
      expect(batch_result.first["body"]["self"].split('/').last).to eq("0")
      expect(batch_result.last["body"]["self"].split('/').last).to eq("0")
    end

    it "can send a 5000 create item batch" do
      commands = []
      5000.times do |x|
        commands << [:create_node, {"name" => "Max " + x.to_s}]
      end
      batch_result = @neo.batch *commands
      expect(batch_result.first["body"]["data"]["name"]).to eq("Max 0")
      expect(batch_result.last["body"]["data"]["name"]).to eq("Max 4999")
    end

  end
end
