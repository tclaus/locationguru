namespace :counters do
  desc "Update counter fields (year, month, day) to single date field"
  task set_counter: :environment do
    puts "Going to update #{Counter.count} location Counters"
    ActiveRecord::Base.transaction do
      Counter.find_each do |counter|
        puts "Update counter: #{counter}"
        if counter.year? && counter.month? && counter.day?
          counter.date_of_count = Date.new(counter.year, counter.month, counter.day)
          counter.save!
        end
        print '.'
      end
    end
    puts ' All done now!'
  end
end
