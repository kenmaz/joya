class PingController < ApplicationController

	def index
		lng = request.headers["HTTP_ACCEPT_LANGUAGE"]
		@jp = lng =~ /^ja/
	end

	def json 
    pings = Ping.find(:all, :conditions => ["la > 30 AND ln > 130"], :limit=>30, :order=>'updated_at DESC')
		lng = request.headers["HTTP_ACCEPT_LANGUAGE"]
		jp = lng =~ /^ja/
		pings.each{|ping| ping.jp = jp}
		render :json=>pings.to_json(:methods=>"time")
	end

	def ping
		Ping.check_and_create(params)
		@pings = Ping.find(:all, :limit=>30, :order=>'created_at DESC, id DESC')
	end

	def remove
		Ping.delete(params[:id])
		redirect_to :action=>:ping
	end
end
