class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status"}
  validate :does_not_overlap_approved_request

  belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: "Cat"

  def overlapping_requests
    CatRentalRequest.select.where(cat_id: cat_id)
    #check for overlapping dates logic
  end

  def overlapping_approved_requests
    overlapping_requests.select.where(status: 'APPROVED')

  end

  def does_not_overlap_approved_request
    overlapping_requests.exists?
  end

end
