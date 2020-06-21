namespace :counters do
  desc "Remove invalid counters"
  task remove_invalid_counter: :environment do
    ActiveRecord::Base.transaction do
      Counter.where('context IS NULL').each do |counter|
        puts "Remove invalid counter: #{counter}"
        counter.destroy!
        print '.'
      end
    end
    puts ' All done now!'
  end
end
