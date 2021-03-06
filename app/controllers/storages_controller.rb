class StoragesController < ApplicationController
    require 'net/http'
    def access_logs
        log_index = cookies[:log_index] ? cookies[:log_index] : 0
        log = request_logs log_index

        @log_array = log.gsub("\n", ' ').split

        # get next index then remove last element from array
        next_access_index = @log_array[@log_array.length - 1]
        cookies[:log_index] = { value: next_access_index, expires: 2.hour.from_now }
        @log_array.delete_at(@log_array.length - 1)
        
        respond_to do |format|
            format.json
            format.text { render text: log}
        end
    end
    def index
        cookies[:log_index] = { value: 0, expires: 2.hour.from_now }
=begin
        log_index = cookies[:log_index] ? cookies[:log_index] : 0
        cookies[:log_index] = { value: 0, expires: 2.hour.from_now } unless log_index != 0
        log = request_logs log_index

        @log = log
        @log_array = log.gsub("\n", ' ').split
=end
    end
    def create
    end
    def new
    end
    def edit
    end
    def show
    end
    def update
    end
    def destroy
    end
    def request_logs log_index
        upserver_url = URI.parse("http://seoyujin.github.io/")
        req = Net::HTTP::Get.new(upserver_url.to_s)
        res = Net::HTTP.start(upserver_url.host, upserver_url.port) {|http| http.request(req)}

        url = URI.parse("#{res.body.strip}/log?start=#{log_index}")
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http| http.request(req)}
        res.body
    end

=begin
    def parse(log)
        # improvement: make model, then build collection, then make jsonbuilder to build response

        json_response = {}
        log_array = log.split("\n")
        log_array.each do |line|
            log_elements = line.split("_")
            if log_elements[0] == 'donate'
                element = {
                    action_type: log_elements[0],
                    account: log_elements[1],
                }
            else
                element = {
                    action_type: log_elements[0],
                    file_name: log_elements[1],
                    chunk: log_elements[2],
                    account: log_elements[3],
                    upload_type: log_elements[4]
                }
            end
            json_response[:] << element
        end
    end
=end
end
