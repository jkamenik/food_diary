require 'spec_helper'

describe EntriesHelper do
  context ".todays_date" do
    subject { helper.todays_date }
    
    it { should == Time.now.to_date }
  end
end
