require "tgm/version"
require "gmail"
require "thor"
require "shellwords"

module Tgm
  # Your code goes here...
  class CLI < Thor 
    desc 'login', 'Log into your gmail account.'
    def login
      $username = ask 'Enter your username:'
      $password = ask 'Enter your password:'
      $gmail = Gmail.connect!($username, $password)
      say 'User Authorized!'
      to_mail = ask 'Enter email-id:'
      subject_mail = ask 'Enter subject:'
      body_mail = ask 'Enter body:'
      email=$gmail.compose do
        to to_mail
        subject subject_mail
        body body_mail
      end
      $gmail.deliver(email)
      $gmail.logout
    end
    desc 'mail', 'Send an email.'
    def mail
      to_mail = ask 'Enter email-id:'
      subject_mail = ask 'Enter subject:'
      body_mail = ask 'Enter body:'
      email=$gmail.compose do
        to to_mail
        subject subject_mail
        body body_mail
      end
      $gmail.deliver(email)
      $gmail.logout
    end
  end
end

