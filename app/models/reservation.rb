class Reservation < ApplicationRecord
  enum status: [:pending, :active, :finished, :paid, :canceled]
  belongs_to :property
  belongs_to :user
  has_many   :talks
  before_create :set_pending_status

  # Força a ter esses campos preenchidos para criar um Reservation
  validates_presence_of :property, :user

  def evaluate (comment, new_rating)
    Reservation.transaction do #transaction reverts everything that was committed in db if something go wrong
      property = self.property

      # Gera um Novo comentário
      Comment.create(property: property, body: comment, user: self.user)
      # Calcula a nova nota da Propriedade
      quantity        = property.reservations.where(evaluation: true).count
      property.rating = (((property.rating * quantity) + new_rating) / (quantity + 1))
      property.save!

      # Seta o evaluation como true
      self.evaluation = true
      self.save!
    end
  end

  def set_pending_status
    self.status ||= :pending
  end

  def interval
    (self.checkout_date - self.checkin_date).to_i
  end
end
