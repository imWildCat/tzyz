class Cpanel::ManagementLogsController < Cpanel::ApplicationController
  include ApplicationHelper

  def show
    @logs = ManagementLog.order(id: :desc).includes(:user, :manageable).paginate(page: current_page, per_page: 20)
  end
end
