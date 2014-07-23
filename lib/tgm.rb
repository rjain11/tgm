require "tgm/version"
require "gmail"
require "thor"
require "shellwords"

module Tgm
  # Your code goes here...
  class CLI < Thor 
    desc 'login', 'Log into your gmail account.'
    def login
    end
    desc 'closer', 'puts closer'
    def closer
      puts("Method Works: Closer")
    end
  end
end

