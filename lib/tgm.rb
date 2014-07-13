require "tgm/version"
require "gmail"

module Tgm
  # Your code goes here...
  class Chatter
  	def say_hello
  		puts("Hi! Welcome to terminal_gmail")
		puts("Enter Username: ")
		username = gets().chomp
		puts("Enter Password: ")
		password = gets().chomp

		gmail = Gmail.connect!(username, password)
		puts("Authorized User!")
		puts("Enter email-id of the person you want to send the email:")
		gid=gets().chomp
		puts("Enter the subject of the mail: ")
		sub=gets().chomp
		puts("Enter the message: ")
		body_mail=gets()
		body_mail= body_mail.to_s + 'Sent from Terminal'

		puts("Any attachment(y/n): ")
		flag_attachment=gets().chomp
		if flag_attachment.to_s =='y'
			puts('Enter the path for the attachment:')
			attachment_path=gets().chomp
		elsif flag_attachment.to_s !='y'
			puts('No attachment! Preparing to send the mail....')
		end
		puts("Send? Click s to send. Anything else will abort the operation.")
		flag_send=gets().chomp

		if flag_send=='s'
			email=gmail.compose do
  				to gid
  				subject sub
    			body body_mail
    			#add_file attachment_path
  			end
  			gmail.deliver(email)
  			puts()
  			puts("Email sent!")
  		else
  			puts("Aborted..Thanks for using Terminal Gmail")
  		end	
	gmail.logout
  	end
  end
end
