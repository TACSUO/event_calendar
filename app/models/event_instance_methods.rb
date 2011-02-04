module EventInstanceMethods
  attr_accessor :start_time, :end_time, :start_date, :end_date
  
  def start_time
    @start_time ||= start_on
  end
  
  def end_time
    @end_time ||= end_on
  end
  
  def start_date
    @start_date ||= start_on.present? ? start_on.to_date : start_on
  end
  
  def end_date
    @end_date ||= end_on.present? ? end_on.to_date : end_on
  end

  def start_year
    start_on.present? ? start_on.in_time_zone(timezone).year : start_on
  end
  
  def start_month
    start_on.present? ? start_on.in_time_zone(timezone).strftime("%B") : start_on
  end
  
  def start_day
    start_on.present? ? start_on.in_time_zone(timezone).day : start_on
  end
  
  def end_day
    end_on.present? ? end_on.in_time_zone(timezone).day : end_on
  end
  
  def one_day?
    start_on.day == end_on.day &&
    start_on.month== end_on.month &&
    start_on.year == end_on.year
  end
  
  def date
    one_day? ? one_day_date : multi_day_date
  end
  
  def one_day_date
    start_on.in_time_zone(timezone).strftime('%A, %B %d %Y')
  end
  
  def multi_day_date
    return one_day_date if end_on.blank?
    "#{start_on.in_time_zone(timezone).strftime('%A, %B %d')} - "+
    "#{end_on.in_time_zone(timezone).strftime('%A, %B %d %Y')}"
  end
end
