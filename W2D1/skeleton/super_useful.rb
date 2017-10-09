# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError
  numbers = %w{zero one two three four five six seven eight nine}
  if numbers.include?(str)
    return numbers.index(str)
  else
    puts "Error: not a valid argument"
    return nil
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError
  def message
    "I will give you another chance."
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts e.message
    retry
  rescue StandardError
    puts "I don't like whatever that is"
    return
  end
  puts "Thanks for the #{maybe_fruit}"
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise "There's no name." if name.empty?
    raise "Not enough years known." if yrs_known < 5
    raise "There's no fav_pastime." if fav_pastime.empty?

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
