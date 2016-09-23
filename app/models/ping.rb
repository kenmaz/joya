class Ping < ActiveRecord::Base
	attr_accessible :uid, :la, :ln, :nickname, :count
	attr_accessor :jp

	def self.check_and_create(params)
		la = params[:la]
		ln = params[:ln]
		uid = params[:uid]
		nickname = params[:nickname]
		count = params[:count] 
		if la && ln && uid && nickname && count
			ping = Ping.find_by_uid(uid)
			unless ping
				ping = Ping.new(:uid=>uid)	
			end
			ping.update_attributes(:la=>la, :ln=>ln, :nickname=>nickname, :count=>count)
			ping.save!
		end
	end

	def time
		diff = (DateTime.now.to_f - updated_at.to_f).to_i
		day = diff.to_i / 1.day.to_i
		hour = (diff % 1.day.to_i) / 1.hour.to_i
		min = (diff % 1.hour.to_i) / 1.minute.to_i
		sec = (diff % 1.minute.to_i)
		if day > 0
			"#{day} days"
		elsif hour > 0
			"#{hour} hours"
		elsif min
			"#{min} minutes"
		else
			"#{sec} seconds"
		end	
	end
end
