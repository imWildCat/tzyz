module RepliesHelper
  def get_page(position)
    position / Topic.replies_per_page + 1
  end
end
