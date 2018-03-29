class HardWorker
  include Sidekiq::Worker

  def perform(complexity)
		case complexity
		when 'high'
			sleep 20
			puts 'Its high complexity takes time'
		when 'medium'
			sleep 10
			puts 'Its medium complexity takes less time'
		else 
			sleep 1
			puts 'Its easy job'
		end
	end
end
