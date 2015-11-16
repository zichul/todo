module ApplicationHelper
  def bootstrap_class_for flash_type
    { notice: "info", success: "success", error: "danger", alert: "warning"}[flash_type.to_sym] || flash_type.to_s
  end
end
