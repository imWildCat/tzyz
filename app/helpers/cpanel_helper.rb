module CpanelHelper
  def class_active(target_path)
    (target_path == request.path) ? 'active' : ''
  end

  def generate_changes_history(changed_object)
    changed_object.changes.each do |k, v|
      changed_object.management_histories.new(user: current_user, action_type: :updating,
                                              field_changed: k, old_value: v[0], new_value: v[1]).save
    end
  end
end
