class Service < ApplicationRecord
  CATEGORIES = ["Divorce", "Pension Alimentaire", "Stationnement", "Excès de vitesse", "Licenciement", "Harcèlement", "Fiscalité", "Impayés", "Abus de faiblesse", "Traffic d'influence", "Corruption", "Financement illégal"]
  belongs_to :user
  has_many :procedures, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  validates :duration, presence: true
  validates :price, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:category, :title, :description],
    associated_against: {
      user: [:last_name, :first_name, :job, :address, :specialty]
    },
    using: {
      tsearch: { prefix: true }
    }
end
