require 'rubygems'
include RubyCards

hand=Hand.new
deck=Deck.new

deck.shuffle!

hand.Draw(deck,5)
puts hand