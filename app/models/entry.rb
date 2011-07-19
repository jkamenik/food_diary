class Entry < ActiveRecord::Base
  before_validation :set_time, :copy_older, :expand_meal_time
  
  validates_presence_of :food
  validates_presence_of :amount
  
  validates_format_of :meal_time, :with => /\d?\d:\d\d(am|pm)/, :message => 'should be in the form of a time'
  validates_presence_of :location
  validates_presence_of :sensory
  validates_presence_of :emotional
  
private
  def set_time
    self.time ||= Time.now.to_date
  end
  
  def copy_older
    # time is set eariler
    older = Entry.find_last_by_time self.time
    return unless older
    
    self.meal_time = older.meal_time if self.meal_time.blank?
    self.location  = older.location if self.location.blank?
    self.sensory   = older.sensory if self.sensory.blank?
    self.emotional = older.emotional if self.emotional.blank?
  end
  
  def expand_meal_time
    return if self.meal_time.blank?
    return if self.meal_time.include? ':'
    if self.meal_time =~ /(\d)(am|pm)/
      self.meal_time = "#{$1}:00#{$2}"
    end
  end
end
