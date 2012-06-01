class Spree::Issue < ActiveRecord::Base
  belongs_to :magazine, :class_name => "Spree::Variant"
  belongs_to :magazine_issue, :class_name => "Spree::Variant"
  has_many :shipped_issues

  attr_accessible :name, :published_at, :magazine

  delegate :subscriptions,:to => :magazine

  validates :name, 
            :presence => true,
            :unless => "magazine_issue.present?"

  def name
    magazine_issue.present? ? magazine_issue.name : read_attribute(:name)
  end

  def ship!
    subscriptions.each{ |s| s.ship!(self) }
  end
  
end
