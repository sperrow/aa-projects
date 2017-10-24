class Cat < ApplicationRecord
  # attr_reader :COLORS
  COLORS = %w(black orange white brown gray)
  SEX = %w(M F)
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: SEX,
    message: "%{value} is not a valid sex" }

  def age
    (Date.today - self.birth_date).to_i / 365
  end

  def colors
    COLORS
  end


end
