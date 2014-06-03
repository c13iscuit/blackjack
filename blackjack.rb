require 'pry'

class Card
  attr_reader :rank
  attr_reader :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def face_card?
    if ["J","Q","K"].include?(@rank)
      @rank = 10
    else
      @rank = @rank
    end
  end

  def is_ace?
    if @rank == "A"
      true
    end
  end
end

class Deck
  def initialize
    @ranks = [2,3,4,5,6,7,8,9,"J","Q","K","A"]
    @suits = ["♥","♠","♣","♦"]
  end

  def build_deck
    @deck = []
    @ranks.each do |rank|
      @suits.each do |suit|
        @deck << Card.new(rank, suit)
      end
    end
    @deck = @deck.shuffle
  end

  def deal_card #hand as arg
    @card = @deck.pop
  end
end

class Hand
  attr_reader :cards
  def initialize(deck)
    @deck = deck
    @cards = []
    2.times do
      @cards << deck.deal_card
    end
  end

  def hit_me(deck)
    @cards << deck.deal_card
  end

  def add_raw_hand
    @raw_score = 0
    @cards.each do |card|
      if card.is_ace? != true
        card.face_card?
        @raw_score = card.rank + @raw_score
      else
        if @raw_score < 11
          @raw_score = @raw_score + 11
        else
          @raw_score = @raw_score + 1
        end
      end
    end
    @raw_score
  end

  def show_cards
    puts "Your cards are:"
    @cards.each do |card|
      puts "#{card.rank}#{card.suit}"
    end
  end

  def show_dealer_cards
    puts "Dealer cards are:"
    @cards.each do |card|
      puts "#{card.rank}#{card.suit}"
    end
  end

end

my_deck = Deck.new
my_deck.build_deck
player_hand = Hand.new(my_deck)
dealer_hand = Hand.new(my_deck)
puts "Welcome to blackjack"
player_hand.show_cards
dealer_hand.show_dealer_cards

puts "Would you like to hit or stay?"
input = gets.chomp
while player_hand.add_raw_hand < 21
  if input == "hit"
    player_hand.hit_me(my_deck)
    player_hand.show_cards
    player_hand.add_raw_hand
    if player_hand.add_raw_hand > 21
      puts "bust!"
      break
    end
  elsif input == "stay"
    while dealer_hand.add_raw_hand < 17
      dealer_hand.hit_me(my_deck)
      dealer_hand.show_dealer_cards
    end
    if dealer_hand.add_raw_hand < 22 && dealer_hand.add_raw_hand > player_hand.add_raw_hand
      puts "dealer wins!"
    elsif dealer_hand.add_raw_hand < 22 && dealer_hand.add_raw_hand < player_hand.add_raw_hand
      puts "player wins!"
    elsif dealer_hand.add_raw_hand > 21
      puts "dealer busts!"
    else
      puts "push!"
    end
    break
  else
    puts "please type 'hit' or 'stay'"
  end
  puts "Would you like to hit or stay?"
  input = gets.chomp
end



# if dealer_hand.add_raw_hand < 22 && dealer_hand.add_raw_hand > player_hand.add_raw_hand
#   puts "dealer wins!"
# elsif dealer_hand.add_raw_hand < 22 && dealer_hand.add_raw_hand < player_hand.add_raw_hand
#   puts "player wins!"
# elsif dealer_hand.add_raw_hand > 21
#   puts "dealer busts!"
# else
#   puts "push!"
# end



