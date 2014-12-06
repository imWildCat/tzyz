module CpanelHelper
  def class_active(*args)
    args.each do |a|
      return 'active' if (a == request.path)
    end
    ''
  end

  def class_active_start_with(*args)
    args.each do |prefix|
      return 'active' if request.path.start_with? prefix
    end
    ''
  end

  def button_to_new_object_path(path)
    button_to '新增', path, class: 'btn btn-success btn-sm pull-right', method: :get
  end

  # def generate_updating_history(changed_object)
  #   changed_object.changes.each do |k, v|
  #     changed_object.management_histories.create(user: current_user, action_type: :updating,
  #                                             field_changed: k, old_value: v[0], new_value: v[1])
  #   end
  # end

  def generate_creating_log(saved_new_object)
    saved_new_object.management_logs.create(user: current_user, action_type: :creating)
  end

  class ActiveRecord::Base
    def assign_attributes_with_log(new_attributes, by_admin)
      assign_attributes new_attributes
      if valid?
        changes.each do |k, v|
          if k == 'content'
            management_logs.create(user: by_admin, action_type: :updating,
                                        field_changed: k)
          else
            management_logs.create(user: by_admin, action_type: :updating,
                                        field_changed: k, old_value: v[0], new_value: v[1])
          end
        end
      end
    end
  end

end
