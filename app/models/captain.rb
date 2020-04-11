class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns all captains of catmarans
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    #returns captains with sailboats
    # includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    #returns captains of motorboats and sailboats
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    # includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    #returns captains of motorboats and sailboats
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    #returns people who are not captains of the boat 
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
