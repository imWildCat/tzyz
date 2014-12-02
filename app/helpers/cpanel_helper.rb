module CpanelHelper
  def class_active(target_path)
    (target_path == request.path) ? 'active' : ''
  end
end
