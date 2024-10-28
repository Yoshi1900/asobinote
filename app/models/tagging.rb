class Tagging < ApplicationRecord
  belongs_to :playground
  belongs_to :tag
end
