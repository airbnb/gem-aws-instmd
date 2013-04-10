require 'net/http'

module AWS
  class InstMD
    VERSION = '0.1.0'

    def self.method_missing name, *args, &block
      @@root ||= InstMD.new
      @@root.method(name).call(*args, &block)
    end

    # Can't be the first one to make that pun.
    # Still proud.
    class Hashish < Hash
      def method_missing name
        self[name.to_s.gsub('_', '-')]
      end
    end

    class Treeish < Hashish
      private
      def initialize http, prefix
        entries = InstMD.query http, prefix
        entries.lines.each do |l|
          l.chomp!
          if l.end_with? '/'
            self[l[0..-2]] = Treeish.new http, "#{prefix}#{l}"
          # meta-data/public-keys/ entries have a '0=foo' format
          elsif l =~ /(\d+)=(.*)/
            number, name = $1, $2
            self[name] = Treeish.new http, "#{prefix}#{number}/"
          else
            self[l] = InstMD.query http, "#{prefix}#{l}"
          end
        end
      end
    end

    attr_accessor :user_data, :meta_data, :dynamic

    # Amazon, Y U NO trailing slash entries
    # in /, /$version and /$version/dynamic/??
    # There is waaay too much code here.
    def initialize version='latest', host='169.254.169.254', port='80'
      http = Net::HTTP.new host, port
      @meta_data = Treeish.new http, "/#{version}/meta-data/"
      @user_data = InstMD.query http, "/#{version}/user-data"
      @dynamic = Hashish.new

      begin
        dynamic_stuff = InstMD.query(http, "/#{version}/dynamic/").lines
      rescue
        dynamic_stuff = []
      end
      dynamic_stuff.each do |e|
        e = e.chomp.chomp '/'
        @dynamic[e] = Treeish.new http, "/#{version}/dynamic/#{e}/"
      end
    end

    def self.query http, path
      rep = http.request Net::HTTP::Get.new path
      unless Net::HTTPOK === rep
        raise Net::HTTPBadResponse, "#{rep.code} #{path}"
      end
      rep.body
    end
  end
end
