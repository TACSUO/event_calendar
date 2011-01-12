module EventInstanceMethods
  attr_accessor :start_time, :end_time, :start_date, :end_date
  
  def start_time
    @start_time ||= start_on.present? ? start_on.in_time_zone(timezone) : start_on
  end
  
  def end_time
    @end_time ||= end_on.present? ? end_on.in_time_zone(timezone) : end_on
  end
  
  def start_date
    @start_date ||= start_on.present? ? start_on.in_time_zone(timezone).to_date : start_on
  end
  
  def end_date
    @end_date ||= end_on.present? ? end_on.in_time_zone(timezone).to_date : end_on
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
  
  def end_year
    end_on.present? ? end_on.in_time_zone(timezone).year : end_on
  end
  
  def end_month
    end_on.present? ? end_on.in_time_zone(timezone).strftime("%B") : end_on
  end
  
  def end_day
    end_on.present? ? end_on.in_time_zone(timezone).day : end_on
  end
  
  def one_day?
    start_day == end_day &&
    start_month == end_month &&
    start_year == end_year
  end
end
