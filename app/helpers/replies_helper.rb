module RepliesHelper
  REPLIES_PER_PAGE = 20
  def get_page(position)
    position / REPLIES_PER_PAGE + 1
  end
end
