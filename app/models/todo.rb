class Todo < ActiveRecord::Base
  belongs_to :list
  validate :list, presence: true

  def toogle_check
    self.checked = not self.checked
  end

end
