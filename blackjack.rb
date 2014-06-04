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

  def deal_card
    @card = @deck.pop
  end
end

class Hand
  attr_reader :cards
  attr_reader :score
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
    score = 0
    @cards.each do |card|
      if card.is_ace? != true
        card.face_card?
        score = card.rank + score
      end
    end
    score
  end

  def add_aces(raw_score)
    @cards.each do |card|
      if card.is_ace? == true
        if raw_score < 11
          raw_score = raw_score + 11
        else
        end
      end
    end
    raw_score
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

dhand = dealer_hand.add_aces(dealer_hand.add_raw_hand)
phand = player_hand.add_aces(player_hand.add_raw_hand)

if phand == 21
  puts "blackjack!"
end

puts "Would you like to hit or stay?"
input = gets.chomp
while phand < 21
  if input == "hit"
    player_hand.hit_me(my_deck)
    player_hand.show_cards
    player_hand.add_raw_hand
    player_hand.add_aces(player_hand.add_raw_hand)
    phand = player_hand.add_aces(player_hand.add_raw_hand)
    if phand > 21
      puts "bust!"
      break
    end
  elsif input == "stay"
    while dhand < 17
      dealer_hand.hit_me(my_deck)
      dealer_hand.show_dealer_cards
      dealer_hand.add_raw_hand
      dhand = dealer_hand.add_aces(dealer_hand.add_raw_hand)
    end
    if dhand < 22 && dhand > phand
      puts "dealer wins!"
    elsif dhand < 22 && dhand < phand
      puts "player wins!"
    elsif dhand > 21
      puts "dealer busts!"
    elsif dhand == phand
      puts "push!"
    else
    end
    break
  else
    puts "please type 'hit' or 'stay'"
  end
  puts "Would you like to hit or stay?"
  input = gets.chomp
end
