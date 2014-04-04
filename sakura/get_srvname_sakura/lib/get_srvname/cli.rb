#: coding: utf-8

require 'thor'
require 'yaml'
require 'json'
require 'uri'
require 'httpclient'

#  is1a https://secure.sakura.ad.jp/cloud/zone/is1a/api/cloud/1.1/ (第1ゾーン)
#  is1b https://secure.sakura.ad.jp/cloud/zone/is1b/api/cloud/1.1/ (第2ゾーン)
ZONES = %w[ is1a is1b ] 

module Srvname
  class SakuraCli < Thor
    class_option :conf, :required => true
    class_option :group, :required => false
    class_option :timeout, :required => false, :default => 60
 
    desc "get", "get server name"
    def get
      conf = YAML.load_file(options[:conf])
      group = options[:group]
      access_token = conf['apikey']['access_token']
      access_token_secret = conf['apikey']['access_token_secret']

      client = HTTPClient.new
      entry = ""
      ZONES.each do |zone|
        uri_prefix = "https://secure.sakura.ad.jp/cloud/zone/#{zone}/api/cloud/1.1/"
        client.set_auth(uri_prefix, access_token, access_token_secret)
        url = URI.join(uri_prefix, 'server').to_s
        res=nil
        begin
          timeout( options[:timeout].to_i ) {
            res = client.get(url)
          }
        rescue Exception => e
          puts "  #{e}"
          next
        end
        if res == nil
          puts "  response is empty."
        elsif res.status_code.to_i != 200
          puts "  an occurred error processing your request. (#{res.status_code})"
        else
          result = ""
          json = JSON.parse(res.content)
          json['Servers'].each do |server|
            if group != nil
              tag = nil
              server['Tags'].each do |t|
                if t == group
                  tag = t
                  break
                end
              end 
              if tag == nil
                next
              end
            end
            name = server['Name']
            if name == nil
              name = server['Interfaces'].first['UserIPAddress'] 
            end
            if name == nil
              next
            end
            puts name
          end
        end
      end
    end
  end
end
