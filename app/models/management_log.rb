class ManagementLog < ActiveRecord::Base

  enum action_type: [:creating, :updating, :destroying]

  belongs_to :user
  belongs_to :manageable, polymorphic: true

  def action_type_name
    case action_type
      when 'creating'
        return '新建'
      when 'updating'
        return '修改'
      when 'destroying'
        return '删除'
      else
        '未知动作'
    end
  end

end
