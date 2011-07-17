require 'spec_helper'

describe Entry do
  context "#save" do
    subject { Entry.new }
    before { subject.save }
    it { subject.time.should == Time.now.to_date }
  end
end
