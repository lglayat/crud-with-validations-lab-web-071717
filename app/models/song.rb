class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validate :unique_title_in_year
  # validate :need_release_year
  # validates :release_year, presence: false, unless: :released?
  validates :release_year, {if: :released?, numericality: {only_integer: true, less_than_or_equal_to: Date.today.year }}

  def unique_title_in_year
    Song.all.each do |s|
      if s.title == self.title && s.release_year == self.release_year
        errors.add(:title) << "Cannot be repeated by same artist in the same year"
      end
    end
  end

  def need_release_year
    if self.released == true && self.release_year == nil
      errors.add(:release_year) << "Release year needed"
    end
  end


  def valid_release_year
    binding.pry
    if self.release_year > Date.today.year
      errors.add(:release_year) << "Enter a valid release year"
    end
  end



end
