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
    start_on.year
  end

  def start_month
    start_on.strftime("%B")
  end
  
  def start_day
    start_on.day
  end
  
  def end_year
    end_on.year
  end
  
  def end_month
    end_on.strftime("%B")
  end
  
  def end_day
    end_on.day
  end
  
  def one_day?
    start_day == end_day
  end
end
