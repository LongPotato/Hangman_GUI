Shoes.setup do
  gem 'random-word', '~> 1.3.0'
end

require 'random-word'

Shoes.app(title: "Hangman", width: 500, height: 500, resizable: false) do

  class Hangman

  	attr_accessor :current_word, :turn, :missed, :word

  	def initialize
  	  
  	end

  	def new_game
      RandomWord.exclude_list << /_/
      content = [RandomWord.adjs.next, RandomWord.nouns.next] #generate a random word
      valid_words = content[rand(2)].upcase
      @word = valid_words.split('')  
      @current_word = Array.new(@word.size, '_')
      @missed = []
      @turn = 10 

      debug(message: "The word is #{@word.join}")
      debug(message: "The current word is #{@current_word.join(' ')}")

  	end

    def take_guess(input)
      if @word.none? { |letter| letter == input }
        @missed << input unless @missed.include?(input) #don't insert the letter if it's already existed
        @turn -= 1
      else
        @word.each_with_index do |letter, index|
          @current_word[index] = letter if input == letter
        end
      end
    end

  end

  @action = Hangman.new
  @c_turn = 10
  @c_miss = ""
  @c_word = ""
  @words_field = nil
  @missed_field = nil
  @turns_field = nil

  def display_game
    @c_turn = @action.turn
    @c_word = @action.current_word.join(' ')
    @c_miss = @action.missed.join(' ')
    @words_field.replace(@c_word)
    @turns_field.replace("Turn Remaining: #{@c_turn}")
    @missed_field.replace("Missed: #{@c_miss}")
  end

  stack  width: 500, height: 500 do

  	stack width: 1.0, height: 0.6 do
  	  background( "#C4C4C4".."#FAFFFF" )
  	  @words_field = para @c_word
  	  @words_field.style(size: "x-large", align: "center", margin_top: 50, weight: "heavy")

      @turns_field = para "Turn Remaining: #{@c_turn}"
      @turns_field.style(size: 18, align: "center", margin_top: 90)
      
      @missed_field = para "Missed: #{@c_miss}"
      @missed_field.style(size: 18, align: "center")

  	end

  	stack width: 1.0, height: 0.4 do
  	  background rgb(245, 245, 245)

 	    flow width: 1.0, height: 0.6 do
        ('A'..'Z').each do |letter|
          button letter, width: 50, height: 40, align: "center" do
            debug(message: "Button value: #{letter}")
            
            @action.take_guess(letter)

            @c_word = @action.current_word.join(' ')
            @words_field.replace(@c_word)

            @c_miss = @action.missed.join(' ')
            @missed_field.replace("Missed: #{@c_miss}")

            @c_turn = @action.turn
            @turns_field.replace("Turn Remaining: #{@c_turn}")

            if @c_word.split(' ').none? { |blank| blank == '_' }  #game win if there's no blank left
              if confirm("YOU WIN! \n Replay?")
                @action.new_game
                display_game
              end
            end
            
            if @c_turn == 0
              @c_word = @action.word
              @words_field.replace(@c_word)
              if confirm("You suck!. The word is #{@c_word.join} \n Replay?")
                @action.new_game
                display_game
              end
            end

          end
        end
      end

  	  flow margin_left: 100, margin_top: 30 do	 		
	      button "New Game" do
	        @action.new_game
          display_game
		    end
		    button "Save Game" do	
		    end
		    button "Load Game" do
	 	    end
 	    end		
    end

  end 
end
