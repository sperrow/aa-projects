
def first_anagram?(word, anagram)
  permutations_arr = word.chars.permutation.to_a
  permutations = permutations_arr.map { |arr| arr.join("")}
  permutations.include?(anagram)
end

def second_anagram?(word, anagram)
  return false if word.length != anagram.length
  word.chars.each_with_index do |char|
    word_i = word.index(char)
    ana_i = anagram.index(char)
    word.slice!(word_i) if word_i
    anagram.slice!(ana_i) if ana_i
  end
  anagram.empty?
end


puts second_anagram?("hello", "elhod")

def third_anagram?(word, anagram)
  word.chars.sort == anagram.chars.sort
end

puts third_anagram?("hellohello", "ellhoolleh")
puts third_anagram?("hellohello", "elggoolleh")

def fourth_anagram?(word, anagram)
  word_count = Hash.new(0)
  anagram_count = Hash.new(0)

  word.chars.each { |ch| word_count[ch] += 1 }
  anagram.chars.each { |ch| anagram_count[ch] += 1 }

  return false unless word_count.keys.length == anagram_count.keys.length

  word_count.each_key do |key|
    return false unless word_count[key] == anagram_count[key]
  end
  true
end

puts fourth_anagram?("hellohello", "ellhoolleh")
puts fourth_anagram?("hellohello", "elggoolleh")

def fifth_anagram?(word, anagram)
  word_count = Hash.new(0)

  word.chars.each { |ch| word_count[ch] += 1 }
  anagram.chars.each { |ch| word_count[ch] -= 1 }

  word_count.none? { |k, v| v != 0 }
end

puts fifth_anagram?("hellohello", "ellhoolleh")
puts fifth_anagram?("hellohello", "elggoolleh")
