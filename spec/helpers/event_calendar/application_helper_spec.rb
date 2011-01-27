require 'spec_helper'

describe EventCalendar::ApplicationHelper do
  describe "time_with_zones (singular)" do
    it "returns times" do
      time = Time.now
      helper.time_with_zones(time).should eq [
        ["Eastern", time.in_time_zone("Eastern Time (US & Canada)").strftime(TIME_BASE)],
        ["Central", time.in_time_zone("Central Time (US & Canada)").strftime(TIME_BASE)],
        ["Mountain", time.in_time_zone("Mountain Time (US & Canada)").strftime(TIME_BASE)],
        ["Pacific", time.in_time_zone("Pacific Time (US & Canada)").strftime(TIME_BASE)]
      ]
    end
  end
end