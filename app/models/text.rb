class Text < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :intermediary_language, class_name: 'Language', optional: true
  belongs_to :topic_author, class_name: 'Person', optional: true
  belongs_to :status
  belongs_to :volume, optional: true
  belongs_to :section, optional: true
  belongs_to :journal, optional: true
  has_many :text_citations, inverse_of: :text, :dependent => :delete_all
  has_many :standard_numbers, inverse_of: :text, :dependent => :delete_all
  has_many :components, inverse_of: :text, :dependent => :delete_all
  has_many :comments, inverse_of: :text, :dependent => :delete_all


  has_many :other_text_languages, inverse_of: :text, :dependent => :delete_all
  has_many :languages, :through => :other_text_languages, :class_name => 'Language'

  has_many :publication_places, inverse_of: :text, :dependent => :delete_all
  has_many :places, :through => :publication_places, :class_name => 'Place'

  accepts_nested_attributes_for :text_citations, :standard_numbers, :components , reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :other_text_languages, reject_if: :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :publication_places, reject_if: :all_blank, :allow_destroy => true

  paginates_per 60

  default_scope {order("id ASC")}

  has_paper_trail

  def next
    Text.where(["census_id > ?", census_id]).order(census_id: :asc).first
  end

  def previous
    Text.where(["census_id < ?", census_id]).order(census_id: :desc).first
  end
end
