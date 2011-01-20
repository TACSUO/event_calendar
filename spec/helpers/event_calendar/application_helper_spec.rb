require 'spec_helper'

describe EventCalendar::ApplicationHelper do
  describe "time_with_zones (singular)" do
    it "returns times" do
      time = Time.now
      format = "%H:%M"
      helper.time_with_zones(time).should eq [
        ["EST", time.in_time_zone("Eastern Time (US & Canada)").strftime(format)],
        ["CST", time.in_time_zone("Central Time (US & Canada)").strftime(format)],
        ["MST", time.in_time_zone("Mountain Time (US & Canada)").strftime(format)],
        ["PST", time.in_time_zone("Pacific Time (US & Canada)").strftime(format)]
      ]
    end
  end
end