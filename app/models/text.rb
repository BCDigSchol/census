class Text < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :topic_author, class_name: 'Person', optional: true
  belongs_to :status
  has_many :text_citations, inverse_of: :text
  has_many :standard_numbers, inverse_of: :text
  has_many :components, inverse_of: :text

  accepts_nested_attributes_for :text_citations, :standard_numbers, :components, reject_if: :all_blank, allow_destroy: true

  default_scope { order("id ASC") }
end
