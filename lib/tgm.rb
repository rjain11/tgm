require "tgm/version"
require "gmail"
require "thor"
require "shellwords"
require 'yaml'
#create a single login

module Tgm
  # Your code goes here...
  class CLI < Thor 
    desc 'launch', 'Launch gmail in browser'
    def launch
      require 'launchy'
      say 'Launching Gmail...'
      sleep(1)
      Launchy.open( "http://www.gmail.com" )
    end

    desc 'login', 'Log into your gmail account.'
    def login
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      gmail = Gmail.connect!($username, $password)
      say 'User Authorized!'
    end
    desc 'mail', 'Send an email.'
    def mail
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      gmail = Gmail.connect!($username, $password)
      to_mail = ask 'Enter email-id:'
      subject_mail = ask 'Enter subject:'
      body_mail = ask 'Enter body:'
      email=gmail.compose do
        to to_mail
        subject subject_mail
        body body_mail
      end
      gmail.deliver(email)
      gmail.logout
    end
    desc 'inbox', 'Get your inbox statistics'
    def inbox
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      gmail = Gmail.connect!($username, $password)
      noInbox=gmail.inbox.count
      noUnread=gmail.inbox.count(:unread)
      noRead=gmail.inbox.count(:read)
      say 'Number of Mails: '+noInbox.to_s
      say 'Number of Unread Mails: '+noUnread.to_s
      say 'Number of Read Mails: '+noRead.to_s
      gmail.logout
    end
    desc 'labels', 'Manage your labels'
    method_option :all, :type => :boolean
    method_option :name, :aliases => '-n'
    method_option :create, :aliases => '-c'
    method_option :delete, :aliases => '-d'
    method_option :exists, :aliases => '-e'
    def labels
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      gmail = Gmail.connect!($username, $password)
      if options[:all]==true
        @labels=gmail.labels.all
        say 'All Labels:'
        @labels.each do |name|
          say name
        end
      end
      if options[:name]
        noEmailsInLabel=gmail.mailbox(options[:name]).count
        say 'Number of mails in '+(options[:name]).to_s+': '+noEmailsInLabel.to_s
      end
      if options[:create]
        gmail.labels.new(options[:create])
        say 'Label '+options[:create].to_s+' created.'
      end
      if options[:delete]
        gmail.labels.delete(options[:delete])
        say 'Label '+options[:delete].to_s+' deleted.'
      end
      if options[:exists]
        if gmail.labels.exists?(options[:exists])==true
          say 'Label exists.'
        else
          say 'Label does not exists.'
        end
      end
      gmail.logout
    end
    desc 'from', 'Get mails from a specific address'
    method_option :user, :required => true
    def from
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      gmail = Gmail.connect!($username, $password)
      say 'Emails from: '+options[:user].to_s
      say 'Count: '+gmail.mailbox('[Gmail]/All Mail').count(:from => options[:user]).to_s
      @messages=gmail.mailbox('[Gmail]/All Mail').search(:from => options[:user])
      @messages.each do |email|
        say email.raw_message
      end
      gmail.logout
    end
    desc 'read', 'Mark all emails as read.'
    def read
      $username = ask 'Enter your username: '
      $password = ask 'Enter your password: '
      gmail = Gmail.connect!($username,$password)
      @unreademails=gmail.inbox.emails(:unread)
      @unreademails.each do |email|
        email.read!
      end
      gmail.logout
    end
    desc 'delete', 'Delete emails from a particular user'
    method_option :from, :required => true
    def delete
      $username = ask 'Enter your username: '
      $password = ask 'Enter your password: '
      gmail = Gmail.connect!($username,$password)
      gmail.inbox.find(:from => options[:from]).each do |email|
        email.delete!
      end
      gmail.logout
    end
  end
end

