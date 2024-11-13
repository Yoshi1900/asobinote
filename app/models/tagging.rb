class Tagging < ApplicationRecord
  belongs_to :playground
  belongs_to :tag
  belongs_to :post, optional: true
end
