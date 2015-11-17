class Todo < ActiveRecord::Base
  belongs_to :list
  validates :list, presence: true

  def toggle_check
    self.check = !self.check
  end

end
