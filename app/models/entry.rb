class Entry < ActiveRecord::Base
  before_create :set_time
  
private
  def set_time
    self.time ||= Time.now.to_date
  end
end
