class Comment < ApplicationRecord
	def self.lists
		ids = find_by_sql("SELECT array_to_string(array_agg(id order by id desc), ',') as id, count(*) as cnt, 
            to_timestamp(floor((extract('epoch' from created_at) / 300 )) * 300) 
            as interval_alias
            FROM comments GROUP BY interval_alias,ip_address  order by 1,2").map(&:id)    
		where(:id =>ids).order(:id => :desc)
	end
end
