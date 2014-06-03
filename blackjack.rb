require 'pry'

class Card
  attr_reader :rank
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def face_card?
    if ["J","Q","K"].include?(@rank)
      puts @rank
      @rank = 10
    else
      puts @rank
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

  def add_raw_hand
    @raw_score = 0
    @cards.each do |card|
      if card.is_ace? != true
        card.face_card?
        @raw_score = card.rank + @raw_score
        puts @raw_score
      else
        if @raw_score < 11
          @raw_score = @raw_score + 11
          puts "ace"
          puts @raw_score
        else
          @raw_score = @raw_score + 1
        end
      end
    end
  end
end

my_deck = Deck.new
my_deck.build_deck
player_hand = Hand.new(my_deck)
player_hand.add_raw_hand










